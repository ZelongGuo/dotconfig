# https://github.com/nicksp/dotfiles/blob/main/zsh/fzf.zsh
# Use fzf to search through the fd-results via fd (https://github.com/sharkdp/fd) to include hidden files (but exclude .git folders) and respect .gitignore
# See more: https://github.com/junegunn/fzf/blob/master/ADVANCED.md

export FZF_DEFAULT_COMMAND='fd --hidden --exclude .git'  # Updated after FD_EXCLUDES is defined below
export FZF_COMPLETION_TRIGGER='\'
export FZF_TMUX=1
export FZF_TMUX_HEIGHT='80%'

export FZF_COMPLETION_OPTS='--border --info=inline'

# ---------------------------------------------------------------------------------------

# https://vitormv.github.io/fzf-themes/
FZF_COLORS="bg:-1,\
bg+:-1,\
fg:-1,\
fg+:#f44a4a,\
hl:#d8a851,\
hl+:#ceb250,\
header:#ad9c8b,\
border:#b26a6a,\
info:#e4510d,\
prompt:#eb0d0d,\
pointer:#f44a4a,\
marker:#7f61b3,\
spinner:#e4510d"

export FZF_DEFAULT_OPTS="
--height 60% \
--color '$FZF_COLORS' \
--prompt '∷ ' \
--pointer ▶ \
--marker '✔ ' \
--bind ctrl-k:down,ctrl-i:up \
--scheme='path' \
--tiebreak=length
"

# export FZF_DEFAULT_OPTS="
# --height 60% \
# --border sharp \
# --layout reverse \
# --color '$FZF_COLORS' \
# --prompt '∷ ' \
# --pointer ▶ \
# --marker '✔ ' \
# --bind ctrl-k:down,ctrl-i:up \
# --bind='ctrl-o:execute(code {})+abort' \
# --bind 'ctrl-/:change-preview-window(hidden|)' \
# --preview-window='border-sharp' \
# --scheme='path' \
# --tiebreak='length,pathname' \
# --info right"

# Set up fzf key bindings and fuzzy completion
if command -v fzf &>/dev/null; then
    source <(fzf --zsh)
fi

# ---------------------------------------------------------------------------------------
# Centralized array of folder patterns to exclude from all fzf searches
FD_EXCLUDES=(
  --exclude '.cache'
  --exclude '.conda'
  --exclude '.git'
  --exclude '.gmt'
  --exclude '.local'
  # --exclude '.config'
  --exclude '__pycache__'
  --exclude '.bundle'
  --exclude '.themes'
  --exclude '.codeintel'
  --exclude 'python2.7'
  --exclude 'python3.6'
  --exclude 'Library'
  --exclude '.claude'
  --exclude '.npm'
  --exclude '.DS_Store'
  # --exclude 'opt'
)

# Update FZF_DEFAULT_COMMAND to use FD_EXCLUDES for consistency
export FZF_DEFAULT_COMMAND="fd --hidden ${FD_EXCLUDES[*]}"

# Use fd to respect .gitignore, include hidden files and exclude `.git` folders
# - The first argument to the function ($1) is the base path to start traversal
# - This affects file completion (e.g., `vim \ <tab>`)
_fzf_compgen_path() {
  fd --hidden "${FD_EXCLUDES[@]}" . "$1"
}


# Use fd to generate the list for directory completion
# - This affects directory completion (e.g., `cd \ <tab>`)
# - Searches from home directory for easy navigation anywhere
_fzf_compgen_dir() {
  fd --type d --hidden "${FD_EXCLUDES[@]}" . "$HOME"
}

# # Advanced customization of fzf options via _fzf_comprun function
# # - The first argument to the function is the name of the command.
# # - Make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview  'tree -C {} | head -200'   "$@" ;;
    # ssh)          fzf --preview 'dig {}'                   "$@" ;;
    vim)          fd --type f --hidden "${FD_EXCLUDES[@]}" | fzf --preview 'highlight -O ansi -l {} | head -200' "$@" ;;
    *)            fzf --preview 'highlight -O ansi -l {} | head -200'  "$@" ;;
  esac
}

