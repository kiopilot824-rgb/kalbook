#!/bin/sh
set -eu

ENV_FILE="/app/.env"
: > "$ENV_FILE"

# Copy the project's Instagram configuration from Railway Variables.
for name in IG_SESSIONID IG_DS_USER_ID IG_CSRFTOKEN IG_MID IG_IG_DID IG_DATR IG_BASIC_USER IG_BASIC_PASSWORD; do
  eval "is_set=\${$name+x}"
  if [ "$is_set" = "x" ]; then
    eval "value=\${$name}"
    printf '%s=%s\n' "$name" "$value" >> "$ENV_FILE"
  fi
done

export IG_RAILWAY="1"
export HOST="${HOST:-0.0.0.0}"
export PORT="${PORT:-8000}"

exec python /app/start.py --host "$HOST" --port "$PORT" --no-browser
