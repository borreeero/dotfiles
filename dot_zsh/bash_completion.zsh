# Local Bash completion
test -d ${XDG_DATA_HOME:-$HOME/.local/share}/bash-completion/completions/ || return
for f in ${XDG_DATA_HOME:-$HOME/.local/share}/bash-completion/completions/*; do
    source $f
done
