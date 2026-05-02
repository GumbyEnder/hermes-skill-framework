#!/usr/bin/env bash
# validate-connection.sh — Pre-flight health check for Medusa Admin skill
#
# Usage:
#   bash validate-connection.sh
#
# Prerequisites:
#   MEDUSA_ADMIN_URL default: http://localhost:9000
#   MEDUSA_ADMIN_TOKEN or MEDUSA_ADMIN_EMAIL + MEDUSA_ADMIN_PASSWORD

set -euo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

MEDUSA_URL="${MEDUSA_ADMIN_URL:-http://localhost:9000}"
TOKEN="${MEDUSA_ADMIN_TOKEN:-}"
EMAIL="${MEDUSA_ADMIN_EMAIL:-}"
PASSWORD="${MEDUSA_ADMIN_PASSWORD:-}"

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Medusa Admin — Connection Validation"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# ── 1. Backend health check ──
echo -n "  Backend (${MEDUSA_URL})... "
HEALTH=$(curl -sS -o /dev/null -w "%{http_code}" "${MEDUSA_URL}/health" 2>/dev/null || echo "000")
if [ "$HEALTH" = "200" ]; then
    echo -e "${GREEN}✓${NC} reachable"
else
    echo -e "${RED}✗${NC} returned HTTP ${HEALTH}"
    echo ""
    echo "  💡 Backend is down or unreachable. Try:"
    echo "     systemctl --user status medusa-backend"
    echo "     Or load the 'medusa-local-backend-recovery' skill."
    exit 1
fi

# ── 2. Auth check ──
echo -n "  Auth... "

AUTH_HEADER=""

if [ -n "$TOKEN" ]; then
    # Method 1: Pre-generated API token
    AUTH_HEADER="Authorization: Bearer ${TOKEN}"
elif [ -n "$EMAIL" ] && [ -n "$PASSWORD" ]; then
    # Method 2: Email/password → JWT exchange
    echo -n " exchanging JWT... "
    JWT_RESP=$(curl -sS "${MEDUSA_URL}/admin/auth/token" \
        -H "Content-Type: application/json" \
        -d "{\"email\":\"${EMAIL}\",\"password\":\"${PASSWORD}\"}" 2>/dev/null || echo '{"token":""}')
    JWT=$(echo "$JWT_RESP" | python3 -c "import sys,json; print(json.load(sys.stdin).get('token',''))" 2>/dev/null || echo "")
    if [ -n "$JWT" ] && [ "$JWT" != "" ]; then
        AUTH_HEADER="Authorization: Bearer ${JWT}"
    else
        echo -e "${RED}✗${NC} JWT exchange failed"
        echo ""
        echo "  💡 Check MEDUSA_ADMIN_EMAIL and MEDUSA_ADMIN_PASSWORD."
        exit 1
    fi
else
    echo -e "${YELLOW}⟳${NC} skipping (no credentials)"
    echo ""
    echo "  ⚠️  No credentials configured."
    echo "  Set MEDUSA_ADMIN_TOKEN or MEDUSA_ADMIN_EMAIL + MEDUSA_ADMIN_PASSWORD."
    echo "  Skipping store verification..."
    exit 0
fi

# ── 3. Store verification ──
STORE=$(curl -sS "${MEDUSA_URL}/admin/store" -H "${AUTH_HEADER}" 2>/dev/null || echo '{"store":{}}')

if echo "$STORE" | grep -q '"id"'; then
    NAME=$(echo "$STORE" | python3 -c "
import sys, json
d = json.load(sys.stdin).get('store', {})
print(d.get('name', 'Unknown'))
" 2>/dev/null || echo "Unknown")
    CURRENCY=$(echo "$STORE" | python3 -c "
import sys, json
d = json.load(sys.stdin).get('store', {})
print(d.get('default_currency_code', '???').upper())
" 2>/dev/null || echo "???")
    echo -e "${GREEN}✓${NC} valid"
    echo -e "  Store: ${GREEN}${NAME}${NC} (${CURRENCY})"
else
    echo -e "${RED}✗${NC} auth failed or store not configured"
    echo "  Raw response: $(echo "$STORE" | head -c 200)"
    exit 1
fi

# ── 4. Quick stats ──
echo ""
echo "  Quick stats:"
PRODUCT_COUNT=$(curl -sS "${MEDUSA_URL}/admin/products?limit=1" -H "${AUTH_HEADER}" 2>/dev/null | python3 -c "import sys,json; print(json.load(sys.stdin).get('count',0))" 2>/dev/null || echo "?")
ORDER_COUNT=$(curl -sS "${MEDUSA_URL}/admin/orders?limit=1" -H "${AUTH_HEADER}" 2>/dev/null | python3 -c "import sys,json; print(json.load(sys.stdin).get('count',0))" 2>/dev/null || echo "?")
echo -e "  Products: ${GREEN}${PRODUCT_COUNT}${NC}"
echo -e "  Orders:   ${GREEN}${ORDER_COUNT}${NC}"

echo ""
echo -e "  ${GREEN}✓ All checks passed${NC}"
