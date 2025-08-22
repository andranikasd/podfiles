SHELL := /usr/bin/env bash

.PHONY: lint test fmt release

lint:
	@if command -v shellcheck >/dev/null; then shellcheck bin/podfiles; else echo "shellcheck not installed"; fi

test:
	@if command -v bats >/dev/null; then bats -r tests; else echo "bats not installed"; fi

fmt:
	@chmod +x bin/podfiles

release:
	@echo "Tagging release (manual for now). Use GitHub Releases or semantic-release later."
