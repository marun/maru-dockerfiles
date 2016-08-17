#!/bin/bash

set -e

FEDORA_VERSION=${1:-24}
SERVER_URL=${2:-http://obsidian.thesprawl.net:7080}
TAG=${3:-"fedora:latest"}

ROOT_PATH=$(dirname "${BASH_SOURCE}")

DOCKERFILE_TEMPLATE="${ROOT_PATH}/Dockerfile.template"
DOCKERFILE="${ROOT_PATH}/Dockerfile.${FEDORA_VERSION}"

cp "${DOCKERFILE_TEMPLATE}" "${DOCKERFILE}"
sed -i -e "s+__FEDORA_VERSION__+${FEDORA_VERSION}+" "${DOCKERFILE}"
sed -i -e "s+__SERVER_URL__+${SERVER_URL}+" "${DOCKERFILE}"

docker build -t "${TAG}" -f "${DOCKERFILE}" .
