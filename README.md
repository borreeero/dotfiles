# dotfiles

My dotfiles, managed by [chezmoi](https://github.com/twpayne/chezmoi).

## Setup

Requires: curl, git.

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b $HOME/.local/bin init --apply borreeero
```

## Testing

```bash
docker run --rm -it -e TERM ubuntu:latest sh -c "$(cat <<'EOF'
  apt update && apt install -y zsh curl git less tree fzf
  sh -c "$(curl -fsLS get.chezmoi.io)" -- -b $HOME/.local/bin init --apply borreeero
  exec zsh -l
EOF
)"
```
