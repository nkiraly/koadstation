#!/usr/local/bin/bash

# ssh host of webserver to configure
webserverhost=$1

echo "webdevf1 Provisioning Step 020 - freebsdweb - pkg update and ansible"

# stop on error
set -e

ansible=`which ansible-playbook 2>/dev/null`

# if ansible was not found, install it before continuing
if [[ -z $ansible ]]; then
  pkg upgrade --yes
  pkg install --yes sysutils/ansible
  ansible=`which ansible-playbook 2>/dev/null`
fi

if [[ -z $ansible ]]; then
  echo "ansible-playbook still not found after pkg install ansible"
  exit 10
fi
