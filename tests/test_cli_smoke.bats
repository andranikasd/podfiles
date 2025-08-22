#!/usr/bin/env bats
bats_require_minimum_version 1.5.0

setup() {
  CLI="./bin/podfiles"
  [ -x "$CLI" ] || chmod +x "$CLI"
}

@test "version prints semver" {
  run "$CLI" version
  [ "$status" -eq 0 ]
  [[ "$output" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]
}

@test "help exits 0" {
  run "$CLI" --help
  [ "$status" -eq 0 ]
  [[ "$output" =~ USAGE ]]
}

@test "k8s attach without kubectl returns 127 (clean warning)" {
  command -v kubectl >/dev/null && skip "kubectl present on host"
  run -127 "$CLI" k8s attach my-pod
  [ "$status" -eq 127 ]
  [[ "$output" =~ Missing:\ kubectl ]]
}

@test "docker netshoot without docker returns 127 (clean warning)" {
  command -v docker >/dev/null && skip "docker present on host"
  run -127 "$CLI" docker netshoot my-container
  [ "$status" -eq 127 ]
  [[ "$output" =~ Missing:\ docker ]]
}
