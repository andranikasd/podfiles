SHELL := /usr/bin/env bash

.PHONY: lint test dev build lint-docker test-docker dev-docker

# Host
lint:
	@if command -v shellcheck >/dev/null; then shellcheck bin/podfiles; else echo "shellcheck not installed"; fi

test:
	@if command -v bats >/dev/null; then bats -r tests || true; else echo "bats not installed"; fi

dev:
	@echo "Starting dev shell (host)..."; bash

# Dockerized
build:
	docker compose build

lint-docker: build
	docker compose run --rm dev shellcheck bin/podfiles

test-docker: build
	docker compose run --rm dev bats -r tests || true

dev-docker: build
	docker compose run --rm dev
