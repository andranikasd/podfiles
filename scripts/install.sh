#!/usr/bin/env bash
set -euo pipefail
REPO="${REPO:-andranikasd/podfiles}"
BIN="${BIN:-podfiles}"
PREFIX="${PREFIX:-/usr/local/bin}"

tmp="$(mktemp -d)"; trap 'rm -rf "$tmp"' EXIT
curl -fsSL "https://raw.githubusercontent.com/${REPO}/master/bin/${BIN}" -o "$tmp/${BIN}"
chmod +x "$tmp/${BIN}"
sudo mkdir -p "$PREFIX"
sudo mv "$tmp/${BIN}" "$PREFIX/${BIN}"
echo "Installed ${BIN} to ${PREFIX}/${BIN}"
