#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "${SCRIPT_DIR}/common.sh"

ensure_prereqs
mkdir -p "${TOMCAT_ROOT}"

if [[ -x "${TOMCAT_HOME}/bin/catalina.sh" ]]; then
  echo "Tomcat ${TOMCAT_VERSION} is already installed at ${TOMCAT_HOME}"
  exit 0
fi

tmp_archive="${TOMCAT_ARCHIVE}.part"
checksum_file="${TOMCAT_ARCHIVE}.sha1"

echo "Downloading Tomcat ${TOMCAT_VERSION}..."
curl -fsSL "${TOMCAT_DOWNLOAD_URL}" -o "${tmp_archive}"
curl -fsSL "${TOMCAT_CHECKSUM_URL}" -o "${checksum_file}"

expected_checksum="$(tr -d '[:space:]' < "${checksum_file}")"
actual_checksum="$(sha1sum "${tmp_archive}" | awk '{print $1}')"

if [[ "${expected_checksum}" != "${actual_checksum}" ]]; then
  rm -f "${tmp_archive}"
  echo "Checksum verification failed for ${tmp_archive}" >&2
  exit 1
fi

mv "${tmp_archive}" "${TOMCAT_ARCHIVE}"
rm -rf "${TOMCAT_HOME}"
unzip -q "${TOMCAT_ARCHIVE}" -d "${TOMCAT_ROOT}"
chmod +x "${TOMCAT_HOME}"/bin/*.sh

echo "Tomcat installed at ${TOMCAT_HOME}"
