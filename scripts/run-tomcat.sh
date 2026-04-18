#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "${SCRIPT_DIR}/common.sh"

"${SCRIPT_DIR}/setup-tomcat.sh"
stop_running_tomcat
build_war
deploy_war

echo "Starting Tomcat in the foreground at ${APP_URL}"
echo "Press Ctrl+C to stop."
exec "${TOMCAT_HOME}/bin/catalina.sh" run
