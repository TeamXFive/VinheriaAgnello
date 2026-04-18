#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "${SCRIPT_DIR}/common.sh"

cleanup_stale_pid

if ! tomcat_running; then
  echo "Tomcat is not running."
  exit 0
fi

echo "Stopping Tomcat..."
"${TOMCAT_HOME}/bin/shutdown.sh"
wait_for_tomcat_stop

echo "Tomcat stopped."
