#!/bin/bash

set -ex

BASE_DIR="/opt/yum"

mkdir -p "${BASE_DIR}"

reposync -l -n --arch=x86_64 --gpgcheck -q -p "${BASE_DIR}"

for repo in ( "fedora" "updates" );
do
  # TODO: Why isn't this working in a container?
  #createrepo -q --cachedir "${BASE_DIR}/yum_checksum_cache" "${repo}"
done
