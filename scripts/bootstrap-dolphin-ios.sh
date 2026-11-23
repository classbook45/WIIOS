#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BUILD_ROOT="${ROOT_DIR}/.build"
SOURCE_DIR="${BUILD_ROOT}/dolphin-ios"

REPOSITORY="${DOLPHIN_IOS_REPOSITORY:-https://github.com/Provenance-Emu/iCube.git}"
REF="${DOLPHIN_IOS_REF:-develop}"

mkdir -p "${BUILD_ROOT}"

if [[ -d "${SOURCE_DIR}/.git" ]]; then
  echo "==> Updating iOS Dolphin source checkout"
  git -C "${SOURCE_DIR}" fetch --depth=1 origin "${REF}"
  git -C "${SOURCE_DIR}" checkout --detach FETCH_HEAD
else
  echo "==> Cloning iOS Dolphin source"
  git clone --filter=blob:none --no-checkout "${REPOSITORY}" "${SOURCE_DIR}"
  git -C "${SOURCE_DIR}" fetch --depth=1 origin "${REF}"
  git -C "${SOURCE_DIR}" checkout --detach FETCH_HEAD
fi

echo "==> Initializing required Dolphin dependencies"
git -C "${SOURCE_DIR}" submodule update --init --recursive

for required in \
  "Source/iOS/BUILDING.md" \
  "BuildiOSXCFramework.py" \
  "Source/iOS/App/Project.swift" \
  "COPYING"; do
  if [[ ! -e "${SOURCE_DIR}/${required}" ]]; then
    echo "ERROR: expected iOS core file is missing: ${required}" >&2
    exit 1
  fi
done

REVISION="$(git -C "${SOURCE_DIR}" rev-parse HEAD)"
printf '%s\n' "${REVISION}" > "${BUILD_ROOT}/dolphin-ios-revision.txt"

echo "==> iOS Dolphin source is ready"
echo "Repository: ${REPOSITORY}"
echo "Requested ref: ${REF}"
echo "Resolved commit: ${REVISION}"
echo "Source path: ${SOURCE_DIR}"
