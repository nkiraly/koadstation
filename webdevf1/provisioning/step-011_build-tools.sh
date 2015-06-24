#!/bin/bash

# ssh host of webserver to configure
webserverhost=$1

echo "webdevf1 Provisioning Step 011 - bootstrap tools"

# stop on error
set -e

cd /vagrant

# ansible should have been confirmed in boostrap step 010
ansible=`which ansible-playbook 2>/dev/null`

# provision this bootstrap VM build tools
$ansible \
  -i 'localhost,' \
  -c local \
  provisioning/bootstrap-011_build-tools.yml
