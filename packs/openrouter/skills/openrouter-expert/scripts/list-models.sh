#!/usr/bin/env bash
# list-models.sh — Query OpenRouter live model list with optional filtering
# Caches in /tmp/openrouter-cache/ for 5 minutes to avoid rate limiting.
#
# Usage:
#   list-models.sh              # List all model IDs
#   list-models.sh --id QUERY   # Filter model IDs by substring
#   list-models.sh --json       # Full JSON output
#   list-models.sh --pricing    # Show model ID + pricing
#   list-models.sh --tools      # Show models that support tool calling

set -euo pipefail

CACHE_DIR="/tmp/openrouter-cache"
CACHE_FILE="${CACHE_DIR}/models.json"
CACHE_TTL=300  # 5 minutes
API_URL="https://openrouter.ai/api/v1/models"

mkdir -p "$CACHE_DIR"

# Serve from cache if fresh
if [[ -f "$CACHE_FILE" ]]; then
    age=$(( $(date +%s) - $(stat -c %Y "$CACHE_FILE" 2>/dev/null || echo 0) ))
    if (( age < CACHE_TTL )); then
        use_cache=true
    else
        use_cache=false
    fi
else
    use_cache=false
fi

if [[ "$use_cache" == "false" ]]; then
    echo "Fetching ${API_URL} ..." >&2
    if ! curl -sfL -o "$CACHE_FILE" "$API_URL"; then
        echo "ERROR: Failed to fetch models" >&2
        if [[ -f "$CACHE_FILE" ]]; then
            echo "WARNING: Serving stale cache" >&2
        else
            exit 1
        fi
    fi
fi

MODE="${1:-ids}"
QUERY="${2:-}"

case "$MODE" in
    --id)
        jq -r '.data[].id' "$CACHE_FILE" | grep -i "${QUERY,,}" || true
        ;;
    --json)
        jq '.' "$CACHE_FILE"
        ;;
    --pricing)
        jq -r '.data[] | "\(.id)\t\(.pricing.prompt)//\(.pricing.completion)"' "$CACHE_FILE" | \
            grep -i "${QUERY,,}" || true
        ;;
    --tools)
        jq -r '.data[] | select(.supported_parameters // [] | contains(["tools"])) | .id' "$CACHE_FILE" | \
            grep -i "${QUERY,,}" || true
        ;;
    ids|"")
        jq -r '.data[].id' "$CACHE_FILE"
        ;;
    *)
        echo "Usage: $0 [--id QUERY|--json|--pricing QUERY|--tools QUERY]" >&2
        exit 1
        ;;
esac
