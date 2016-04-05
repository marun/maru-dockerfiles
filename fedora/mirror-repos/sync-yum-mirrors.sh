#!/bin/bash

set -ex

BASE_DIR="/opt/yum"

mkdir -p "${BASE_DIR}"

reposync -l -n --arch=x86_64 --gpgcheck -q -p "${BASE_DIR}"
