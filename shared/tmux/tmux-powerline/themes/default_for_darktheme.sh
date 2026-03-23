# Default Theme

if patched_font_in_use; then
	TMUX_POWERLINE_SEPARATOR_LEFT_BOLD=""
	TMUX_POWERLINE_SEPARATOR_LEFT_THIN=""
	TMUX_POWERLINE_SEPARATOR_RIGHT_BOLD=""
	TMUX_POWERLINE_SEPARATOR_RIGHT_THIN=""
else
	TMUX_POWERLINE_SEPARATOR_LEFT_BOLD="◀"
	TMUX_POWERLINE_SEPARATOR_LEFT_THIN="❮"
	TMUX_POWERLINE_SEPARATOR_RIGHT_BOLD="▶"
	TMUX_POWERLINE_SEPARATOR_RIGHT_THIN="❯"
fi

#TMUX_POWERLINE_DEFAULT_BACKGROUND_COLOR=${TMUX_POWERLINE_DEFAULT_BACKGROUND_COLOR:-'235'}
TMUX_POWERLINE_DEFAULT_BACKGROUND_COLOR=${TMUX_POWERLINE_DEFAULT_BACKGROUND_COLOR:-'252'} # NOTE: here the bg color should be same with the middle part of the status bar
TMUX_POWERLINE_DEFAULT_FOREGROUND_COLOR=${TMUX_POWERLINE_DEFAULT_FOREGROUND_COLOR:-'255'}

TMUX_POWERLINE_DEFAULT_LEFTSIDE_SEPARATOR=${TMUX_POWERLINE_DEFAULT_LEFTSIDE_SEPARATOR:-$TMUX_POWERLINE_SEPARATOR_RIGHT_BOLD}
TMUX_POWERLINE_DEFAULT_RIGHTSIDE_SEPARATOR=${TMUX_POWERLINE_DEFAULT_RIGHTSIDE_SEPARATOR:-$TMUX_POWERLINE_SEPARATOR_LEFT_BOLD}


# Format: segment_name background_color foreground_color [non_default_separator]

if [ -z $TMUX_POWERLINE_LEFT_STATUS_SEGMENTS ]; then
	TMUX_POWERLINE_LEFT_STATUS_SEGMENTS=(
		#1 for dark mode
		#1 "tmux_session_info 148 234" \
		#1 "hostname 33 0" \
		#1 "ifstat 30 255" \
		#1 "ifstat_sys 30 255" \
		#1 #"lan_ip 24 255 ${TMUX_POWERLINE_SEPARATOR_RIGHT_THIN}" \
		#1 #"wan_ip 24 255" \
		#1 #"vcs_branch 29 88" \
		#1 #"vcs_compare 60 255" \
		#1 #"vcs_staged 64 255" \
		#1 #"vcs_modified 9 255" \
		#1 #"vcs_others 245 0" \

		# for light mode
		"tmux_session_info 248 0" \
		"hostname 250 0" \
		"ifstat     252 0" \
		"ifstat_sys 252 0" \
		#"lan_ip 24 255 ${TMUX_POWERLINE_SEPARATOR_RIGHT_THIN}" \
		#"wan_ip 24 255" \
		#"vcs_branch 29 88" \
		#"vcs_compare 60 255" \
		#"vcs_staged 64 255" \
		#"vcs_modified 9 255" \
		#"vcs_others 245 0" \
	)
fi

if [ -z $TMUX_POWERLINE_RIGHT_STATUS_SEGMENTS ]; then
	TMUX_POWERLINE_RIGHT_STATUS_SEGMENTS=(
		#"earthquake 3 0" \
		#"pwd 89 211" \
		"load 167 15" \
        # neglect the pwd because the space is so narrow to accommodate when split the windows
		#"pwd 1 15" \
		"uptime 124 15" \
		#"macos_notification_count 29 255" \
		#"mailcount 9 255" \
		#"now_playing 234 37" \
		#"battery 137 127" \
		#"tmux_mem_cpu_load 234 136" \
    		#"cpu 240 136" \
		#"weather 37 255" \
		#"rainbarf 0 ${TMUX_POWERLINE_DEFAULT_FOREGROUND_COLOR}" \
    		#"xkb_layout 125 117" \ 
		# "date_day 235 136" \
		# "date 235 136 ${TMUX_POWERLINE_SEPARATOR_LEFT_THIN}" \
		# "time 235 136 ${TMUX_POWERLINE_SEPARATOR_LEFT_THIN}" \
		#"utc_time 235 136 ${TMUX_POWERLINE_SEPARATOR_LEFT_THIN}" \
	)
fi
