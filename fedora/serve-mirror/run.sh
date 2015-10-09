#!/bin/bash

MIRROR_PATH=/Users/Shared/yum
if [ ! -d "${MIRROR_PATH}" ]; then
  MIRROR_PATH=/opt/data/yum
fi

tag=fedora/serve-mirror
docker build -t ${tag} .
docker run -dt --restart=always --name mirror -p 7080:80 \
  -v ${MIRROR_PATH}:/var/www/html ${tag}
