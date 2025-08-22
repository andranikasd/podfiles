#!/usr/bin/env bats
bats_require_minimum_version 1.5.0

setup() {
  # Source functions/vars without executing CLI
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

_list_applets() {
  local bb="$1"
  # Prefer --list; if not supported, invoke bare to print applet table
  "$bb" --list 2>/dev/null || "$bb" 2>/dev/null
}

@test "BusyBox on current arch exposes expected applets (ping, nslookup, wget, traceroute, sh)" {
  local arch="$(_host_arch)" url
  if [ "$arch" = "arm64" ]; then url="$PODFILES_BUSYBOX_URL_ARM64"; else url="$PODFILES_BUSYBOX_URL_AMD64"; fi

  local bb; bb="$(mktemp)"
  _download_busybox "$url" "$bb"

  run _list_applets "$bb"
  [ "$status" -eq 0 ]
  for app in ping nslookup wget traceroute sh; do
    [[ "$output" =~ (^|[[:space:]])"$app"($|[[:space:]]) ]]
  done
}

@test "Documented: we don't execute cross-arch BusyBox" {
  local arch="$(_host_arch)"
  if [ "$arch" = "arm64" ]; then
    skip "Runner is arm64; not executing amd64 BusyBox"
  else
    skip "Runner is amd64; not executing arm64 BusyBox"
  fi
}
