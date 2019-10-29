#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

docker build -t "maru/systemd:fedora31" .
