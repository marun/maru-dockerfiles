#!/bin/bash

set -e

if [[ "$#" -lt 1 ]]; then
  >&2 echo "Usage: $0 [fedora version, e.g. 23]"
  exit 1
fi

FEDORA_VERSION=$1

ROOT_PATH=$(dirname "${BASH_SOURCE}")

BASE_PATH=/Users/Shared/yum
if [ ! -d "${MIRROR_PATH}" ]; then
  BASE_PATH=/opt/data/yum
fi

MIRROR_PATH="${BASE_PATH}/fedora${FEDORA_VERSION}"

if ! which createrepo &> /dev/null; then
  >&2 echo "Please install the createrepo package"
  exit 1
fi

pushd "${MIRROR_PATH}" > /dev/null
  repos=( "fedora" "updates" )
  for repo in "${repos[@]}"; do
    createrepo -q --cachedir "${MIRROR_PATH}/yum_checksum_cache" "${repo}"
  done
popd > /dev/null
