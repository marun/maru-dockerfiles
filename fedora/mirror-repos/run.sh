#!/bin/bash

tag=fedora/localmirror
docker build -t ${tag} .
docker run -dt -v /Users/Shared/yum:/opt/yum ${tag}
