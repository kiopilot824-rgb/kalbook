#!/bin/sh
set -eu

ENV_FILE="/app/.env"
: > "$ENV_FILE"

while IFS= read -r line; do
  case "$line" in
    ''|'#'*) continue ;;
  esac
  name="${line%%=*}"
  case "$name" in
    ''|*[!A-Za-z0-9_]*|[0-9]*) continue ;;
  esac
  eval "is_set=\${$name+x}"
  if [ "$is_set" = "x" ]; then
    eval "value=\${$name}"
    printf '%s=%s\n' "$name" "$value" >> "$ENV_FILE"
  fi
done < /app/.env.example

export RAILWAY_DEPLOYMENT="1"
export HOST="${HOST:-0.0.0.0}"
export PORT="${PORT:-8000}"

exec python /app/start.py
