#!/usr/local/bin/bash

# ssh host of webserver to configure
webserverhost=$1
# port webserver should consider itself being served as after vagrant port forwarding
webserverhttps=$2

echo "webdevf1 Provisioning Step 021 - freebsdweb - servers"

# stop on error
set -e

pkg install --yes shells/bash
pkg install --yes editors/vim
