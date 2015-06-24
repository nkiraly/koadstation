#!/bin/bash

# ssh host of webserver to configure
webserverhost=$1
# port webserver should consider itself being served as after vagrant port forwarding
webserverhttps=$2

echo "webdevf1 Provisioning Step 120 - webserver server provisioning"

# stop on error
set -e

cd /vagrant

# ansible should have been confirmed in bootstrap step 010
ansible=`which ansible-playbook 2>/dev/null`

# provision the webserver server packages and configuration
$ansible \
  -i '$webserverhost,' \
  --private-key $HOME/vagrant_insecure_private_key \
  provisioning/step-120_servers.yml \
  -e "ENV=local
      webdevf1_https_ip=$webserverhost
      webdevf1_https_port=$webserverhttps
  "
