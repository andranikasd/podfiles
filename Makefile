SHELL := /usr/bin/env bash

.PHONY: lint test fmt build lint-docker test-docker dev-docker

lint:
	@if command -v shellcheck >/dev/null; then shellcheck bin/podfiles; else echo "shellcheck not installed"; fi

test:
	@if command -v bats >/dev/null; then bats -r tests; else echo "bats not installed"; fi

fmt:
	@chmod +x bin/podfiles

# Dockerized workflow
build:
	docker compose build

lint-docker: build
	docker compose run --rm dev shellcheck bin/podfiles

test-docker: build
	docker compose run --rm dev bats -r tests

dev-docker: build
	docker compose run --rm dev
