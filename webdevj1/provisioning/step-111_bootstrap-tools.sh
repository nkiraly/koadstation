#!/bin/bash

echo "webdevj1 Provisioning Step 111 - bootstrap tools"

# stop on error
set -e

cd /vagrant

# ansible should have been confirmed in bootstrap step 010
ansible=`which ansible-playbook 2>/dev/null`

# provision this bootstrap VM build tools
$ansible \
  -i 'localhost,' \
  -c local \
  provisioning/step-111_bootstrap-tools.yml

# make sure vagrant_insecure_private_key file is not world readable
# if the bootstrap VM shared folder comes from a windows vagrant host
chmod 0600 $HOME/vagrant_insecure_private_key
