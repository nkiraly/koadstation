#!/bin/bash

# ssh host of jailhost to configure
jailhost=$1

echo "webdevj1 Provisioning Step 210 - jail configuration and provisioning"

# stop on error
set -e

cd /vagrant

# ansible should have been confirmed in bootstrap step 010
ansible=`which ansible-playbook 2>/dev/null`

# jail configuration and provisioning
# important notes:
# - use the config shipped by Vagrant file file provisioner
# - specify the ansible_python_interpreter because ansible assumes it is the same as the ansible control host
ANSIBLE_CONFIG=/vagrant/provisioning/ansible.cfg $ansible \
  -i "$jailhost," \
  --private-key $HOME/vagrant_insecure_private_key \
  provisioning/step-210_jails.yml \
  -e "ansible_python_interpreter=/usr/local/bin/python2.7
      ENV=local
      webdevj1_ssh_host=$jailhost
  " \
  -v
