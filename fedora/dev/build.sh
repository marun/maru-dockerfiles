#!/bin/bash

TAG=marun/dev
TMP_TAG="${TAG}-tmp"
NAME="dev-build"

docker build -t "${TMP_TAG}" .

# Install emacs so that its dependencies are represented in the volume mount
INSTALL="/home/dev/.emacs.d/install.sh"
docker run -t --name "${NAME}" -v /opt/src:/opt/src -u dev\
 --entrypoint "${INSTALL}" "${TMP_TAG}"

# Commit the new image
docker commit -c 'USER root' -c 'ENTRYPOINT ["/usr/sbin/sshd", "-D"]' "${NAME}" "${TAG}"
docker rm "${NAME}"
docker rmi "${TMP_TAG}"
