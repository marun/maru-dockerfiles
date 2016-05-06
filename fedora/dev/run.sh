#!/bin/bash

mkdir -p /tmp/openshift-dind-cluster
docker run -d -p 7022:22 -v /opt/src:/opt/src -v /opt/data:/opt/data\
 --name dev -h dev -v /var/run/docker.sock:/var/run/docker.sock\
 -v /tmp/openshift-dind-cluster:/tmp/openshift-dind-cluster\
 --restart=always\
 marun/dev /usr/sbin/sshd -D
