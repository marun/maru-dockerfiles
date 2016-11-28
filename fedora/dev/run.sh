#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

mkdir -p /tmp/openshift-dind-cluster
docker run -d -p 7022:22 -v /opt/src:/opt/src -v /opt/data:/opt/data\
 --name dev -h dev -v /var/run/docker.sock:/var/run/docker.sock\
 -v /tmp/openshift-dind-cluster:/tmp/openshift-dind-cluster\
 -v /tmp/openshift:/tmp/openshift\
 -e TZ="${TZ-`readlink /etc/localtime | sed -e 's,.*/usr/share/zoneinfo/,,'`}"\
 --restart=always\
 maru/dev
