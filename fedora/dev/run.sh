#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

mkdir -p /tmp/openshift-dind-cluster
docker run -d -p 7022:22 -v /opt/src:/opt/src -v /opt/data:/opt/data\
 --name dev -h dev -v /var/run/docker.sock:/var/run/docker.sock\
 -v /home/maru/.kube:/home/dev/.kube\
 -v /home/maru/.docker:/home/dev/.docker\
 -v /home/maru/.minikube:/home/maru/.minikube\
 --cap-add=NET_ADMIN --cap-add=NET_BIND_SERVICE\
 --privileged\
 --security-opt=seccomp:unconfined\
 --restart=always\
 --tmpfs /tmp --tmpfs /run\
 -v /sys/fs/cgroup:/sys/fs/cgroup:ro\
 maru/dev:fedora31
# FIXME As of Fedora 31 the system doesn't progress to the desired runlevel
docker exec -t dev rm /var/run/nologin
