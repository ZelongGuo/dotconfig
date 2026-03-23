# -----------------------------------------------------------------
# Function: tmux_preexec (hook function)
# Usage: it automatically checks whether tmux is running and then
# delete the old tmux files and reload new ones, to make sure 
# that every tmux pane have the correct environment.
#
# When you open the terminal for the first time, it'll automatically
# open the tmux session named with zelong, but if you try to open more, 
# it'll throw a error because the session name conflict.
# -----------------------------------------------------------------
tmux_preexec() {
    # Setting variable tmux_event
    local tmux_event=${TMUX%%,*}-event/client-attached-pane
    # Check whether the file (named with tmux_event + pane) existing
    if [[ -f $tmux_event-$TMUX_PANE ]]; then
        # show current tmux environment variables and reload them
        eval $(tmux showenv -s)
        # delete current file of current tmux pane	
        command rm $tmux_event-$TMUX_PANE 2>/dev/null
    fi
}
# # Only run tmux auto-start if tmux is installed
# if ! command -v tmux &>/dev/null; then
#     return
# fi

# Check if tmux is running
if [[ -n $TMUX ]]; then
    local tmux_event=${TMUX%%,*}-event/client-attached-pane
    command rm $tmux_event-$TMUX_PANE 2>/dev/null

    # load add-zsh-hook to current zsh environment
    autoload -U add-zsh-hook
    # add tmux_preexec to preexec hook
    add-zsh-hook preexec tmux_preexec

else  # if tmux is not running, create a new session
    tmux new -s "zelong"
fi


# ----------------------------------------------------------------------------------------
# When you want open multiple terminals, also automatically opening multiple tmux session,
# and name them differently. But it might be not so useful to open multiple terminals ...
# another problem of this method is once you source .zshrc, it'll automatically open the
# other new tmux session ... Thus, do not use these ...
# Anyway, one tmux session is already enough, avoiding to open more as you can use <prefix-c>
# and <prefix-\>, <prefix--> to open more session-like and window-like screen ...
# ----------------------------------------------------------------------------------------
#1 # Automatically create tmux session
#1 start_tmux_session() {
#1   # Set the base session name
#1   session_prefix="zelong"
#1 
#1   # Check if already in a tmux session
#1   if [ -n "$TMUX" ]; then
#1     return  # Already in tmux, skip
#1   fi
#1 
#1   # Get the current session number
#1   session_number=1
#1   while tmux has-session -t "${session_prefix}_${session_number}" 2>/dev/null; do
#1     session_number=$((session_number + 1))
#1   done
#1 
#1   # If session_number=1 is not found, create the first session
#1   if ! tmux has-session -t "${session_prefix}_1" 2>/dev/null; then
#1     tmux new -s "${session_prefix}_1"
#1   else
#1     # Create a new session
#1     tmux new -s "${session_prefix}_${session_number}"
#1   fi
#1 
#1   # After entering the tmux session, automatically handle panel events
#1   handle_tmux_events
#1 }
#1 
#1 # Handle the tmux pane preexec event
#1 tmux_preexec() {
#1     local tmux_event=${TMUX%%,*}-event/client-attached-pane
#1     if [[ -f $tmux_event-$TMUX_PANE ]]; then
#1         eval $(tmux showenv -s)
#1         command rm $tmux_event-$TMUX_PANE 2>/dev/null
#1     fi
#1 }
#1 
#1 # Handle tmux pane events
#1 handle_tmux_events() {
#1   # If inside a tmux session, handle the event file
#1   if [[ -n $TMUX ]]; then
#1     local tmux_event=${TMUX%%,*}-event/client-attached-pane
#1     command rm $tmux_event-$TMUX_PANE 2>/dev/null
#1 
#1     # Load the preexec hook
#1     autoload -U add-zsh-hook
#1     add-zsh-hook preexec tmux_preexec
#1   fi
#1 }
#1 
#1 # Called when the shell starts
#1 if [[ -n $TMUX ]]; then
#1     # If already in a tmux session, handle the event file
#1     handle_tmux_events
#1 else
#1     # Automatically run the session creation function at startup
#1     start_tmux_session
#1 fi
#1 
