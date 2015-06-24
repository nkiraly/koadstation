#!/bin/bash

# ssh host of webserver to configure
webserverhost=$1

echo "webdevf1 Provisioning Step 010 - boostrap - yum update and ansible"

ansible=`which ansible-playbook 2>/dev/null`

# stop on error
set -e

if [[ -z $ansible ]]; then
  sudo yum -y update
  sudo yum -y install epel-release
  sudo yum -y install ansible
  hash -r
  ansible=`which ansible-playbook 2>/dev/null`
fi
