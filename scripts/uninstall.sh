#!/usr/bin/env bash
set -euo pipefail
BIN="${BIN:-podfiles}"
PREFIX="${PREFIX:-/usr/local/bin}"
sudo rm -f "$PREFIX/${BIN}"
echo "Removed ${PREFIX}/${BIN}"
