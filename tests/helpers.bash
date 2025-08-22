# Common helpers for bats
require_cmd() {
  command -v "$1" >/dev/null 2>&1
}
