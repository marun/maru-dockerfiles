#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

KEY_PATH=$(dirname "${BASH_SOURCE}")/id_rsa.pub

if [ ! -f "${KEY_PATH}" ]; then
  >&2 echo "Missing ${KEY_PATH}"
  exit 1
fi

docker build -t "maru/sshd:fedora28" .
