#!/usr/local/bin/bash

echo "webdevf1 Provisioning Step 010 - freebsdweb - pkg update and ansible"

ansible=`which ansible-playbook 2>/dev/null`

# stop on error
set -e

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
