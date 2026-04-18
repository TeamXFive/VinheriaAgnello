#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

APP_NAME="VinheriaAgnello"
TOMCAT_VERSION="${TOMCAT_VERSION:-9.0.117}"
TOMCAT_ROOT="${PROJECT_ROOT}/.tomcat"
TOMCAT_HOME="${TOMCAT_ROOT}/apache-tomcat-${TOMCAT_VERSION}"
TOMCAT_ARCHIVE="${TOMCAT_ROOT}/tomcat-${TOMCAT_VERSION}.zip"
TOMCAT_DOWNLOAD_URL="https://repo.maven.apache.org/maven2/org/apache/tomcat/tomcat/${TOMCAT_VERSION}/tomcat-${TOMCAT_VERSION}.zip"
TOMCAT_CHECKSUM_URL="${TOMCAT_DOWNLOAD_URL}.sha1"
TARGET_WAR="${PROJECT_ROOT}/target/${APP_NAME}.war"
CATALINA_HOME="${TOMCAT_HOME}"
CATALINA_BASE="${TOMCAT_HOME}"
CATALINA_PID="${TOMCAT_HOME}/temp/catalina.pid"
APP_URL="${APP_URL:-http://localhost:8080/${APP_NAME}/}"
USE_NOHUP="true"

export CATALINA_HOME
export CATALINA_BASE
export CATALINA_PID
export USE_NOHUP

if [[ -z "${JAVA_HOME:-}" ]]; then
  JAVA_HOME="$(dirname "$(dirname "$(readlink -f "$(command -v javac)")")")"
  export JAVA_HOME
fi

ensure_command() {
  if ! command -v "$1" >/dev/null 2>&1; then
    echo "Missing required command: $1" >&2
    exit 1
  fi
}

ensure_prereqs() {
  ensure_command curl
  ensure_command javac
  ensure_command mvn
  ensure_command sha1sum
  ensure_command unzip
}

tomcat_pid() {
  if [[ -f "${CATALINA_PID}" ]]; then
    tr -d '[:space:]' < "${CATALINA_PID}"
  fi
}

tomcat_running() {
  local pid
  pid="$(tomcat_pid || true)"
  [[ -n "${pid}" ]] && kill -0 "${pid}" 2>/dev/null
}

cleanup_stale_pid() {
  if [[ -f "${CATALINA_PID}" ]] && ! tomcat_running; then
    rm -f "${CATALINA_PID}"
  fi
}

wait_for_http() {
  local url="$1"
  local timeout_seconds="${2:-60}"
  local waited=0

  while (( waited < timeout_seconds )); do
    if curl -fsS -o /dev/null "${url}"; then
      return 0
    fi

    sleep 1
    waited=$((waited + 1))
  done

  echo "Timed out waiting for ${url}" >&2
  return 1
}

wait_for_tomcat_stop() {
  local timeout_seconds="${1:-30}"
  local waited=0

  while tomcat_running; do
    if (( waited >= timeout_seconds )); then
      echo "Timed out waiting for Tomcat to stop." >&2
      return 1
    fi

    sleep 1
    waited=$((waited + 1))
  done

  cleanup_stale_pid
}

build_war() {
  echo "Building WAR with Maven..."
  (
    cd "${PROJECT_ROOT}"
    mvn -DskipTests package
  )
}

deploy_war() {
  echo "Deploying ${TARGET_WAR}..."
  rm -rf "${TOMCAT_HOME}/webapps/${APP_NAME}" "${TOMCAT_HOME}/webapps/${APP_NAME}.war"
  cp "${TARGET_WAR}" "${TOMCAT_HOME}/webapps/${APP_NAME}.war"
}

stop_running_tomcat() {
  cleanup_stale_pid

  if tomcat_running; then
    echo "Stopping existing Tomcat process..."
    "${TOMCAT_HOME}/bin/shutdown.sh"
    wait_for_tomcat_stop
  fi
}
