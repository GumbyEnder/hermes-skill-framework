#!/usr/bin/env bash
# pull-docs-index.sh — Fetch and cache OpenRouter llms.txt
# Caches in /tmp/openrouter-cache/ for 5 minutes to avoid rate limiting.

set -euo pipefail

CACHE_DIR="/tmp/openrouter-cache"
CACHE_FILE="${CACHE_DIR}/llms.txt"
CACHE_TTL=300  # 5 minutes

mkdir -p "$CACHE_DIR"

# Serve from cache if fresh
if [[ -f "$CACHE_FILE" ]]; then
    age=$(( $(date +%s) - $(stat -c %Y "$CACHE_FILE" 2>/dev/null || echo 0) ))
    if (( age < CACHE_TTL )); then
        cat "$CACHE_FILE"
        exit 0
    fi
fi

# Fetch fresh
echo "Fetching https://openrouter.ai/docs/llms.txt ..." >&2
if curl -sfL -o "$CACHE_FILE" "https://openrouter.ai/docs/llms.txt"; then
    cat "$CACHE_FILE"
else
    echo "ERROR: Failed to fetch llms.txt" >&2
    # Serve stale cache as fallback
    if [[ -f "$CACHE_FILE" ]]; then
        echo "WARNING: Serving stale cache" >&2
        cat "$CACHE_FILE"
    fi
    exit 1
fi
