#!/bin/bash

MIRROR_PATH=/Users/Shared/yum
if [ ! -d "${MIRROR_PATH}" ]; then
  MIRROR_PATH=/opt/data/yum
fi

tag=fedora/localmirror
docker build -t ${tag} .
docker run -dt -v ${MIRROR_PATH}:/opt/yum ${tag}
