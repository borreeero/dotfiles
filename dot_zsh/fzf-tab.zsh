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

