#!/usr/bin/env bash
# remote_start_uvicorn.sh
# Usage: ./remote_start_uvicorn.sh <host> [user] [project_dir]
# Example: ./remote_start_uvicorn.sh ubuntu.tail13f1ca.ts.net ubuntu /home/ubuntu/myproject
set -e
HOST="${1:?host required}"
USER="${2:-ubuntu}"
PROJECT_DIR="${3:-~/project}"

echo "Starting uvicorn on $HOST (user $USER) in $PROJECT_DIR..."
ssh "$USER@$HOST" "mkdir -p ~/logs; cd ${PROJECT_DIR}; source ~/ai-env/bin/activate 2>/dev/null || true; nohup uvicorn serve:app --host 0.0.0.0 --port 8000 > ~/logs/uvicorn.log 2>&1 & echo started"

echo "Command dispatched. Check ~/logs/uvicorn.log on remote host for output."
