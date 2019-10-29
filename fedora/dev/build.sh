#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

TAG="maru/dev:fedora31"
TMP_TAG="${TAG}-tmp"
NAME="dev-build"

docker build -t "${TMP_TAG}" .

# Install emacs so that its dependencies are represented in the volume mount
# seccomp=unconfined is required to build emacs in the image
INSTALL="/home/dev/.emacs.d/install.sh"
docker rm -f "${NAME}"
docker run -t --name "${NAME}" -v /opt/src:/opt/src -u dev\
 --security-opt seccomp=unconfined\
 --entrypoint "${INSTALL}" "${TMP_TAG}"

# Commit the new image
docker commit -c 'USER root' -c 'ENTRYPOINT ["/usr/sbin/init"]' "${NAME}" "${TAG}"
docker rm "${NAME}"
docker rmi "${TMP_TAG}"
