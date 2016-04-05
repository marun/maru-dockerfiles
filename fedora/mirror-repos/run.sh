#!/bin/bash

set -e

FEDORA_VERSION=${1:-23}

ROOT_PATH=$(dirname "${BASH_SOURCE}")

DOCKERFILE_TEMPLATE="${ROOT_PATH}/Dockerfile.template"
DOCKERFILE="${ROOT_PATH}/Dockerfile.${FEDORA_VERSION}"

cp "${DOCKERFILE_TEMPLATE}" "${DOCKERFILE}"
sed -e "s+__FEDORA_VERSION__+${FEDORA_VERSION}+" "${DOCKERFILE}"

BASE_PATH=/Users/Shared/yum
if [ ! -d "${MIRROR_PATH}" ]; then
  if [ -d "/slow" ]; then
    BASE_PATH=/slow/yum
  else
    BASE_PATH=/opt/data/yum
  fi
fi

MIRROR_PATH="${BASE_PATH}/fedora${FEDORA_VERSION}"
mkdir -p "${MIRROR_PATH}"

TAG="marun/localmirror:${FEDORA_VERSION}"
docker build -t "${TAG}" -f "${DOCKERFILE}" .
MIRROR_CID=$(docker run -dt -v "${MIRROR_PATH}:/opt/yum" "${TAG}")

docker wait "${MIRROR_CID}" > /dev/null
# TODO Why wasn't this running properly in the container?
"${ROOT_PATH}"/create-repo.sh "${FEDORA_VERSION}"
