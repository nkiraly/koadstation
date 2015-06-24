#!/bin/bash

# ssh host of webserver to configure
webserverhost=$1

echo "webdevf1 Provisioning Step 111 - bootstrap tools"

# stop on error
set -e

cd /vagrant

# ansible should have been confirmed in bootstrap step 010
ansible=`which ansible-playbook 2>/dev/null`

# provision this bootstrap VM build tools
$ansible \
  -i 'localhost,' \
  -c local \
  provisioning/step-111_build-tools.yml
