#!/usr/bin/env bash
# remote_check.sh
# Usage: ./remote_check.sh <host> [user] [start-uvicorn]
# Example: ./remote_check.sh ubuntu.tail13f1ca.ts.net ubuntu start-uvicorn
set -e
HOST="${1:-ubuntu.tail13f1ca.ts.net}"
USER="${2:-ubuntu}"
ACTION="$3"

echo "Checking DNS for $HOST..."
if command -v dig >/dev/null 2>&1; then
  dig +short "$HOST" || true
else
  getent hosts "$HOST" || true
fi

echo "Pinging $HOST..."
ping -c 2 "$HOST" || true

echo "Testing SSH connection (batch mode, timeout=5s)..."
ssh -o BatchMode=yes -o ConnectTimeout=5 "$USER@$HOST" 'echo SSH_OK' || echo "SSH check failed or requires interactive auth"

echo "Checking remote listening ports (22, 8000) if SSH available..."
if ssh -o ConnectTimeout=5 "$USER@$HOST" 'true' 2>/dev/null; then
  ssh "$USER@$HOST" "sudo ss -tlnp | grep -E ':22 |:8000 ' || sudo netstat -tlnp | grep -E ':22 |:8000 ' || echo 'No standard listeners found or requires sudo'"
else
  echo "Skipping remote port checks because SSH not available."
fi

if [ "$ACTION" = "start-uvicorn" ]; then
  echo "Attempting to start uvicorn on remote host..."
  ssh "$USER@$HOST" "cd ~/project || true; source ~/ai-env/bin/activate 2>/dev/null || true; nohup uvicorn serve:app --host 0.0.0.0 --port 8000 > ~/uvicorn.log 2>&1 & echo started || echo failed"
fi

echo "Done."
