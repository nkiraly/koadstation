#!/usr/local/bin/bash

this_machine_ip=$1

echo "WebDevFreeBSD Provisioning Step 010 - development baseline"

# abort on error
set -e

pkg install --yes editors/vim
