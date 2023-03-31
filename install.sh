#!/usr/bin/env sh

# Install chezmoi
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "$HOME/.local/bin" init --apply --ssh borreeero
echo "Installation finished. You can delete this clone now, it is managed by chezmoi in ~/.local/share/chezmoi"
