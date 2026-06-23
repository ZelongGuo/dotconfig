# ── AI CLI Launcher ──
#
# Responsibilities:
#   1. ccuse selects a Claude model profile and updates the .current-model pointer.
#   2. cc/ccseislip launch Claude Code in a temporary Conda environment and
#      inject the selected model profile.
#   3. cx/cxseislip launch Codex CLI in a temporary Conda environment.
#
# This file never reads or modifies ~/.claude/settings.json. Standard Claude
# Code configuration, including the Status Line, plugins, and permissions,
# remains independently managed by settings.json.
#
# Dependencies: conda, jq, fzf
export CLAUDE_DIR="$HOME/.claude"
export CLAUDE_MODEL_DIR="$CLAUDE_DIR/models"

# Use one error format for every launcher and write errors to stderr, allowing
# callers to distinguish normal output from failures by stream and exit status.
_ai_error() {
    print -u2 -r -- "✗ $*"
}

# Validate the JSON structure before reading or exporting a model profile:
#   - model must be a non-empty string such as sonnet, haiku, or opus;
#   - env must be an object;
#   - every env key must be a valid shell environment-variable name;
#   - every env value must be a string.
# This prevents Claude Code from starting with a partially exported or corrupt
# profile.
_ai_validate_claude_profile() {
    local profile_file="$1"

    jq -e '
        type == "object" and
        (.model | type == "string" and length > 0) and
        (.env | type == "object") and
        (.env | to_entries | all(.[];
            (.key | test("^[A-Za-z_][A-Za-z0-9_]*$")) and
            (.value | type == "string")
        ))
    ' "$profile_file" >/dev/null 2>&1
}

# Select a Claude model interactively with fzf. This function deliberately
# accepts no arguments so there is only one switching interface to maintain.
# The selection updates .current-model and never generates settings.json.
ccuse() {
    # Use status 2 for invalid usage and status 1 for dependency/config errors.
    if (( $# != 0 )); then
        _ai_error "usage: ccuse"
        return 2
    fi

    (( $+commands[jq] )) || { _ai_error "jq is not installed"; return 1; }
    (( $+commands[fzf] )) || { _ai_error "fzf is not installed"; return 1; }

    # zsh's (N) glob qualifier returns an empty array when nothing matches
    # instead of retaining a literal "*.json", making the empty-directory check
    # reliable.
    local -a profiles
    profiles=("$CLAUDE_MODEL_DIR"/*.json(N))
    (( ${#profiles} )) || {
        _ai_error "no model profiles found in $CLAUDE_MODEL_DIR"
        return 1
    }

    # .current-model contains only the profile filename without .json. It is the
    # sole selection state: fzf uses it for the [current] marker and the launcher
    # uses it to locate the selected profile.
    local current=""
    [[ -r "$CLAUDE_DIR/.current-model" ]] && current=$(<"$CLAUDE_DIR/.current-model")

    # Each fzf row is "profile name + TAB + selection marker". Only the text
    # before the TAB is stored, so the display-only [current] marker never enters
    # the state file.
    local selected
    selected=$(
        local profile name marker
        for profile in "${profiles[@]}"; do
            name="${profile:t:r}"
            marker=""
            [[ "$name" == "$current" ]] && marker="[current]"
            print -r -- "${name}"$'\t'"${marker}"
        done | fzf \
            --delimiter=$'\t' \
            --with-nth=1,2 \
            --prompt="Claude model → " \
            --header="Current: ${current:-none}" \
            --height=9 \
            --layout=reverse \
            --border
    ) || return 1

    local model="${selected%%$'\t'*}"
    local profile_file="$CLAUDE_MODEL_DIR/${model}.json"
    if ! _ai_validate_claude_profile "$profile_file"; then
        _ai_error "invalid model profile: $profile_file"
        return 1
    fi

    # Write to a sibling temporary file and atomically replace the pointer with
    # mv. If writing is interrupted, the previous selection remains intact and
    # an empty .current-model is never exposed.
    local tmp="$CLAUDE_DIR/.current-model.tmp.$$"
    if ! print -r -- "$model" >| "$tmp"; then
        _ai_error "cannot write model selection"
        return 1
    fi
    if ! mv -f -- "$tmp" "$CLAUDE_DIR/.current-model"; then
        rm -f -- "$tmp"
        _ai_error "cannot update model selection"
        return 1
    fi

    print -r -- "✓ Claude model: $model"
}

_ai_load_claude_profile() {
    (( $+commands[jq] )) || {
        _ai_error "jq is not installed"
        return 1
    }

    # Claude launchers require an existing valid selection. They never open fzf
    # implicitly, which avoids blocking automation or non-interactive shells.
    local current_file="$CLAUDE_DIR/.current-model"
    if [[ ! -s "$current_file" ]]; then
        _ai_error "no valid Claude model selected; run: ccuse"
        return 1
    fi

    local profile
    profile=$(<"$current_file")
    local profile_file="$CLAUDE_MODEL_DIR/${profile}.json"
    if [[ ! -f "$profile_file" ]] || ! _ai_validate_claude_profile "$profile_file"; then
        _ai_error "no valid Claude model selected; run: ccuse"
        return 1
    fi

    # Pass model through claude --model. Export endpoint, token, and provider
    # model mappings from env one entry at a time. @tsv allows zsh to split each
    # key/value pair without using eval.
    local model env_lines entry key value
    model=$(jq -er '.model' "$profile_file") || {
        _ai_error "cannot read model from $profile_file"
        return 1
    }
    env_lines=$(jq -r '.env | to_entries[] | [.key, .value] | @tsv' "$profile_file") || {
        _ai_error "cannot read environment from $profile_file"
        return 1
    }

    for entry in "${(@f)env_lines}"; do
        key="${entry%%$'\t'*}"
        value="${entry#*$'\t'}"
        export "$key=$value"
    done

    # _ai_launch needs both values after this function returns, so they are
    # global within the temporary subshell. They disappear when that subshell
    # exits and therefore cannot pollute the original Tmux pane.
    typeset -g _AI_CLAUDE_PROFILE="$profile"
    typeset -g _AI_CLAUDE_MODEL="$model"
}

# The parenthesized function body runs the complete launch flow in a temporary
# subshell:
#   - it inherits the current directory and terminal;
#   - conda activate modifies only this temporary shell;
#   - Claude/Codex, their shell commands, and subagents inherit the activated env;
#   - the original Tmux pane keeps its previous Conda state after the CLI exits.
_ai_launch() (
    local tool="$1"
    local env_name="$2"
    shift 2

    # Platform-specific macOS/Linux config defines $conda as the path to
    # conda.sh. Shell startup stores only this path; Conda itself is loaded lazily
    # when an AI CLI launcher runs.
    local conda_init="${conda:-}"
    if [[ -z "$conda_init" || ! -r "$conda_init" ]]; then
        _ai_error "Conda initialization script is unavailable: ${conda_init:-unset}"
        return 1
    fi

    source "$conda_init" || {
        _ai_error "failed to initialize Conda"
        return 1
    }
    conda activate "$env_name" || {
        _ai_error "cannot activate Conda environment: $env_name"
        return 1
    }

    # Resolve the executable after Conda activation so the CLI and every child
    # process observe the same PATH.
    local executable
    executable=$(command -v "$tool") || {
        _ai_error "$tool is not installed"
        return 1
    }

    if [[ "$tool" == "claude" ]]; then
        # Claude additionally loads the selected model profile. exec replaces
        # the temporary shell with the CLI so signals, TTY behavior, and the exit
        # status propagate directly to the original terminal.
        _ai_load_claude_profile || return 1
        print -r -- "Claude Code | model: $_AI_CLAUDE_PROFILE | conda: $CONDA_DEFAULT_ENV"
        print -r -- "cwd: $PWD"
        exec "$executable" --model "$_AI_CLAUDE_MODEL" "$@"
    fi

    # Codex does not use Claude model profiles; it inherits only the selected
    # Conda environment.
    print -r -- "Codex CLI | conda: $CONDA_DEFAULT_ENV"
    print -r -- "cwd: $PWD"
    exec "$executable" "$@"
)

# Older configuration defined alias cc='claude code'. Remove it before defining
# the function to prevent alias expansion and to make re-sourcing ~/.zshrc safe
# in an already-running terminal.
unalias cc 2>/dev/null

# Fixed command-to-environment mappings. All additional arguments are forwarded
# unchanged to the corresponding CLI.
cc() {
    _ai_launch claude temp "$@"
}

ccseislip() {
    _ai_launch claude seislip "$@"
}

cx() {
    _ai_launch codex temp "$@"
}

cxseislip() {
    _ai_launch codex seislip "$@"
}
