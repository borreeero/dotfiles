#!/usr/bin/env sh

BASEDIR=$(dirname "$0")

# Install chezmoi
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "$HOME/.local/bin" init "$BASEDIR"
