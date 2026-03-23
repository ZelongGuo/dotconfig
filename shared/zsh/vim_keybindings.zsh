#bindkey '^v' edit-command-line
bindkey -v
bindkey -M vicmd "h" vi-insert
bindkey -M vicmd "H" vi-insert-bol
bindkey -M vicmd "j" vi-backward-char
bindkey -M vicmd "l" vi-forward-char
bindkey -M vicmd "J" vi-beginning-of-line
bindkey -M vicmd "L" vi-end-of-line
bindkey -M vicmd "k" down-line-or-history
bindkey -M vicmd "i" up-line-or-history
bindkey -M vicmd "u" undo
# 'jk' go to VI mode
bindkey -M viins 'jk' vi-cmd-mode
#bindkey -M vicmd "-" vi-rev-repeat-search
#bindkey -M vicmd "=" vi-repeat-search
#bindkey -M vicmd "h" vi-forward-word-end

# function zle-line-init zle-keymap-select {
#     RPS1="${${KEYMAP/vicmd/-- NORMAL --}/(main|viins)/-- INSERT --}"
#     RPS2=$RPS1
#     zle reset-prompt
# }
# zle -N zle-line-init

function zle-keymap-select {
	if [[ ${KEYMAP} == vicmd ]] || [[ $1 = 'block' ]]; then
		echo -ne '\e[1 q' 	    # cursor with block shape
	elif [[ ${KEYMAP} == main ]] || [[ ${KEYMAP} == viins ]] || [[ ${KEYMAP} = '' ]] || [[ $1 = 'beam' ]]; then
		echo -ne '\e[5 q'
  fi
}

zle -N zle-keymap-select

# Use beam shape cursor on startup.
echo -ne '\e[5 q'

# Use beam shape cursor for each new prompt.
preexec() {
	echo -ne '\e[5 q'
}

_fix_cursor() {
	echo -ne '\e[5 q'
}
precmd_functions+=(_fix_cursor)

# NOTE: here is improtant, you should dpecify the KEYTIMEOUT >= 20 ms
KEYTIMEOUT=20

