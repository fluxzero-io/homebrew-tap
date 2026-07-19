# AGENTS.md

Instructions for coding agents working in this repository.

## Purpose

This repository is the official Homebrew tap for Fluxzero tools. Formulae install immutable artifacts from tagged
GitHub releases. Keep changes small, reproducible, and tied to an upstream release.

## Validation

- Run `brew audit --strict --online Formula/fluxzero.rb` after changing the formula.
- Run `brew install --formula Formula/fluxzero.rb` and `brew test fluxzero` when testing on a supported host.
- Never change a checksum without verifying it against the corresponding immutable GitHub release asset.
- Formula updates must preserve both the `fz` command and the `fluxzero` alias.

## Releases

- Formula versions must match a published `fluxzero-io/fluxzero-cli` release tag.
- Support macOS arm64, macOS x86_64, and Linux x86_64 while those upstream assets are published.
- Do not build the CLI in this repository. Install the native artifacts produced and tested by the CLI release pipeline.

## Commit Messages

Use Conventional Commits, for example `chore(fluxzero): update to 1.4.1`.
