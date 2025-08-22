#!/usr/bin/env bats

setup() {
  CLI="./bin/podfiles"
  [ -x "$CLI" ] || chmod +x "$CLI"
}

@test "NO_COLOR disables ANSI codes in help" {
  run env NO_COLOR=1 "$CLI" --help
  [ "$status" -eq 0 ]
  [[ "$output" != *"\033["* ]]   # no raw escape sequences
  [[ "$output" =~ "USAGE" ]]
}

@test "help includes product tagline" {
  run "$CLI" --help
  [ "$status" -eq 0 ]
  [[ "$output" =~ "Fuckless Debugging in containerized environments" ]]
}
