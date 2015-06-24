#!/usr/local/bin/bash

this_machine_ip=$1

echo "WebDevFreeBSD Provisioning Step 001 - pkg update and ansible install"

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
