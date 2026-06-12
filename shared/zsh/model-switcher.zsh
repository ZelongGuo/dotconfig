# ── Claude Code Model Switcher ──
# Depends on: jq, fzf (in Brewfile)
export CLAUDE_DIR="$HOME/.claude"
export CLAUDE_MODEL_DIR="$CLAUDE_DIR/models"

# Select LLM you want to use
ccuse() {
    local model="${1:-}"
    if [[ -z "$model" ]]; then
        model=$(ls "$CLAUDE_MODEL_DIR"/*.json 2>/dev/null \
                | xargs -I{} basename {} .json \
                | fzf --prompt="Claude Code Model → " --height=7)
        [[ -z "$model" ]] && return 1
    fi

    local fragment="$CLAUDE_MODEL_DIR/${model}.json"
    local base="$CLAUDE_DIR/settings-base.json"

    if [[ ! -f "$fragment" ]]; then
        echo "✗ unknown model: $model"
        echo "  available: $(ls "$CLAUDE_MODEL_DIR"/*.json | xargs -I{} basename {} .json | tr '\n' ' ')"
        return 1
    fi

    # Auto-detect runtime drift (new plugins, config changes) before overwriting
    if [[ -f "$CLAUDE_DIR/settings.json" ]]; then
        local runtime_common base_norm
        runtime_common=$(jq -S 'del(.model,.permissions) | .env |= with_entries(select(.key == "PATH" or .key == "CONDA_PREFIX" or .key == "CONDA_DEFAULT_ENV"))' "$CLAUDE_DIR/settings.json" 2>/dev/null)
        base_norm=$(jq -S 'del(.permissions)' "$base" 2>/dev/null)
        if [[ -n "$runtime_common" && "$runtime_common" != "$base_norm" ]]; then
            echo "⚠ drift: settings.json has unsaved changes — run ccsync to persist"
        fi
    fi

    # Preserve current permissions from the existing settings.json
    local perms='{}'
    [[ -f "$CLAUDE_DIR/settings.json" ]] && perms=$(jq '{permissions: .permissions}' "$CLAUDE_DIR/settings.json" 2>/dev/null)
    [[ -z "$perms" || "$perms" == "null" ]] && perms='{}'

    # Three-layer deep merge: base × fragment × permissions
    jq -s '.[0] * .[1] * .[2]' "$base" "$fragment" <(echo "$perms") >| "$CLAUDE_DIR/settings.json"
    echo "$model" >| "$CLAUDE_DIR/.current-model"
    echo "✓ switched to $(cat "$CLAUDE_DIR/.current-model") — restart Claude Code to apply"
}

# List all the LLMs and highlight the current one
cclist() {
    local current=$(cat "$CLAUDE_DIR/.current-model" 2>/dev/null)
    echo "models: $CLAUDE_MODEL_DIR/"
    for f in "$CLAUDE_MODEL_DIR"/*.json; do
        [[ ! -f "$f" ]] && continue
        local name=$(basename "$f" .json)
        if [[ "$name" == "$current" ]]; then
            echo "  ⚡ $name  ← current"
        else
            echo "     $name"
        fi
    done
}

# Sync runtime changes from settings.json back to settings-base.json
# (e.g. newly installed plugins, marketplace entries, config tweaks)
ccsync() {
    local base="$CLAUDE_DIR/settings-base.json"
    local runtime="$CLAUDE_DIR/settings.json"
    local tmp="/tmp/cc-sync-$$.json"

    [[ ! -f "$runtime" ]] && { echo "✗ settings.json not found"; return 1; }

    # Strip model-specific fields: .model + env keys that aren't shared
    # Keep only PATH, CONDA_PREFIX, CONDA_DEFAULT_ENV in the env block
    jq 'del(.model) | .env |= with_entries(select(.key == "PATH" or .key == "CONDA_PREFIX" or .key == "CONDA_DEFAULT_ENV"))' \
        "$runtime" > "$tmp"

    # Show what will change (sorted-key diff)
    echo "Changes to sync:"
    diff <(jq -S . "$base") <(jq -s '.[0] * .[1]' "$base" "$tmp" | jq -S .) || true

    # Deep merge stripped runtime config into base
    jq -s '.[0] * .[1]' "$base" "$tmp" >| "$base"
    rm -f "$tmp"
    echo "✓ synced — run ccuse to regenerate settings.json"
}
