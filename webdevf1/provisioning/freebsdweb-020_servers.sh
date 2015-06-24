#!/usr/local/bin/bash

this_machine_ip=$1

echo "WebDevFreeBSD Provisioning Step 010 - development baseline"

# stop on error
set -e

pkg install --yes shells/bash
pkg install --yes editors/vim
