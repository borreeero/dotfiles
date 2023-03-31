# zsh completion options

# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# trigger complete on empty prompt instead of inserting a tab
zstyle ':completion:*' insert-tab false

# fzf

# Note: FZF_DEFAULT_COMMAND defined in fzf plugin
local fzf_binds=(
	"shift-left:preview-half-page-up"
	"shift-right:preview-half-page-down"
	"?:toggle-preview"
	"ctrl-/:change-preview-window\(right,62%\|down,62%\|hidden\)" # for some reason we need to escape "()|"" here
	"alt-z:toggle-preview-wrap"
	"backward-eof:abort"
)
# preview window with ~ goldenratio proportions
export FZF_DEFAULT_OPTS="--bind=${(j:,:)fzf_binds} --preview-window=right:62%:wrap --ansi"
[ "${TERM}" = linux ] && FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS} --no-unicode --color=16,border:bold" || true
unset fzf_binds
export FZF_CTRL_T_COMMAND="command find -L . -mindepth 1 \\( -path '*/\\.git' -o -fstype 'sysfs' -o -fstype 'devfs' -o -fstype 'devtmpfs' -o -fstype 'proc' \\) -prune \
    -o -type f -print -o -type d -print -o -type l -print 2> /dev/null | cut -b3- | sort"
export FZF_CTRL_T_OPTS="--select-1 --exit-0 --preview 'less {}'"
export FZF_ALT_C_COMMAND="command find -L . -mindepth 1 \\( -path '*/\\.git' -o -fstype 'sysfs' -o -fstype 'devfs' -o -fstype 'devtmpfs' -o -fstype 'proc' \\) -prune \
    -o -type d -print 2> /dev/null | cut -b3- | sort"
export FZF_ALT_C_OPTS="--select-1 --exit-0 --preview 'tree -C {} | head -200'"
export FZF_CTRL_R_OPTS=
# for ** completion
export FZF_COMPLETION_OPTS="--preview 'less {}'"

# fzf-tab options

# switch group using `<` and `>`
zstyle ':fzf-tab:*' switch-group '<' '>'
# no prefix: https://github.com/Aloxaf/fzf-tab/pull/183#issuecomment-787080931
zstyle ':fzf-tab:*' prefix ''

# fzf window with ~ goldenratio proportions
zstyle ':fzf-tab:*' fzf-flags "--height=62%"

# git
zstyle ':fzf-tab:complete:git-(show|cherry-pick):*' fzf-preview 'git show --color=always $word'
zstyle ':fzf-tab:complete:git-(show|cherry-pick):argument-rest' fzf-preview 'git show --color=always $word'
zstyle ':fzf-tab:complete:git-*:argument-rest' continuous-trigger ''  # do not accept on '/'
zstyle ':fzf-tab:complete:git-*:options' fzf-preview  # no preview
zstyle ':fzf-tab:complete:git-*' fzf-preview '[ "$group" = "[command]" ] && exit; [ -z "$realpath" ] && git show --color=always $word || less ${(Q)realpath}'
zstyle ':completion:complete:git-*' sort false  # trust order of git completion

# different oneline preview for commands
zstyle ':fzf-tab:complete:-command-:*' fzf-preview \
	'{ [ "${group}" = "[external command]" ] && { whatis -l "${word}"  2>/dev/null || echo "${word} - ${group}" } | perl -pe "s/(.*?) - /$(print -P -f %s "%B\1%b")\n\n/" } || { print -P "%B${word}%b\n\n${group:1:-1}"}'
zstyle ':fzf-tab:complete:-command-:*' fzf-flags '--preview-window=down:5:wrap'
# preview variables
zstyle ':fzf-tab:complete:(-parameter-|-brace-parameter-|export|unset|expand):*' fzf-preview 'echo ${(PF)word:-$(print -P "%B<empty>%b")}'
zstyle ':fzf-tab:complete:(-parameter-|-brace-parameter-|export|unset|expand):*' fzf-flags '--preview-window=down:5:wrap'

# apt
zstyle ':fzf-tab:complete:apt:*' fzf-preview 'apt-cache show $word'

# processes
# give a preview of commandline arguments when completing `kill`
zstyle ':completion:*:*:*:*:processes' command 'ps -u $USERNAME -o pid,user,cmd -w -w'
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-preview \
	'[[ $group == "[process ID]" ]] && ps --pid=$word -f -w -w'
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-flags '--preview-window=down:5:wrap'
zstyle ':fzf-tab:complete:(kill|ps):*' fzf-preview

# systemctl
zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview 'SYSTEMD_COLORS=1 systemctl --user status -- $word 2>/dev/null || SYSTEMD_COLORS=1 systemctl status -- $word'
zstyle ':fzf-tab:complete:service:argument-1' fzf-preview 'SYSTEMD_COLORS=1 service $word status 2>/dev/null'
zstyle ':fzf-tab:complete:systemctl*:*' fzf-flags '--preview-window=:hidden'

# do not use preview pane in nala
zstyle ':fzf-tab:complete:nala:argument-rest' fzf-preview

# preview directory's content when completing cd
zstyle ':fzf-tab:complete:(cd):*' fzf-preview 'less ${(Q)realpath} | head -200'
zstyle ':fzf-tab:complete:*' fzf-preview 'echo "default preview" && less ${(Q)realpath}'
zstyle ':fzf-tab:complete:*:(argument-rest)' fzf-preview 'less ${(Q)realpath}'
zstyle ':fzf-tab:complete:*:(options|argument-*|)' fzf-preview  # no preview for options or commands without completion available

