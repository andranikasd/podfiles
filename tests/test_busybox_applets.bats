#!/usr/bin/env bats

setup() {
  PODFILES_SOURCE_ONLY=1 source ./bin/podfiles
}

_download_busybox() {
  local url="$1" out="$2"
  curl -fsSL "$url" -o "$out"
  chmod +x "$out"
}

_host_arch() {
  case "$(uname -m)" in
    x86_64|amd64) echo amd64 ;;
    aarch64|arm64) echo arm64 ;;
    *) echo amd64 ;;
  esac
}

@test "BusyBox on current arch exposes expected applets (ping, nslookup, wget, traceroute, sh)" {
  local arch="$(_host_arch)"
  local url
  if [ "$arch" = "arm64" ]; then
    url="$PODFILES_BUSYBOX_URL_ARM64"
  else
    url="$PODFILES_BUSYBOX_URL_AMD64"
  fi

  local bb; bb="$(mktemp)"
  _download_busybox "$url" "$bb"

  # We can only *execute* if the binary matches host arch.
  run "$bb" --list
  [ "$status" -eq 0 ]
  for app in ping nslookup wget traceroute sh; do
    [[ "$output" =~ (^|[[:space:]])"$app"($|[[:space:]]) ]]
  done
}

@test "Skip cross-arch BusyBox execution (documented expectation)" {
  local arch="$(_host_arch)"
  if [ "$arch" = "arm64" ]; then
    skip "Runner is arm64; not executing amd64 BusyBox"
  else
    skip "Runner is amd64; not executing arm64 BusyBox"
  fi
}