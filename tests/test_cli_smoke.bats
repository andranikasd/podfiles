#!/usr/bin/env bats

load ./helpers.bash

setup() {
  CLI="./bin/podfiles"
  [[ -x "$CLI" ]] || chmod +x "$CLI"
}

@test "version prints a semantic version" {
  run "$CLI" version
  [ "$status" -eq 0 ]
  [[ "$output" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]
}

@test "help exits 0" {
  run "$CLI" --help
  [ "$status" -eq 0 ]
  [[ "$output" =~ "USAGE" ]]
}

@test "k8s attach without kubectl returns 127" {
  if require_cmd kubectl; then skip "kubectl present on runner"; fi
  run "$CLI" k8s attach my-pod
  [ "$status" -eq 127 ]
  [[ "$output" =~ "Missing: kubectl" ]]
}

@test "docker netshoot without docker returns 127" {
  if require_cmd docker; then skip "docker present on runner"; fi
  run "$CLI" docker netshoot my-container
  [ "$status" -eq 127 ]
  [[ "$output" =~ "Missing: docker" ]]
}
