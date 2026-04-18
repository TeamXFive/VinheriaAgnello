#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "${SCRIPT_DIR}/common.sh"

"${SCRIPT_DIR}/setup-tomcat.sh"
stop_running_tomcat
build_war
deploy_war

echo "Starting Tomcat in the background..."
"${TOMCAT_HOME}/bin/startup.sh"
wait_for_http "${APP_URL}"

echo "Application is running at ${APP_URL}"
