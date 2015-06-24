#!/bin/bash

vmhost=$1
vmport=$2

# stop on error
set -e

ansible=`which ansible-playbook 2>/dev/null`

if [[ -z $ansible ]]; then
  sudo yum -y update
  sudo yum -y install epel-release
  sudo yum -y install ansible
  hash -r
  ansible=`which ansible-playbook 2>/dev/null`
fi

cd /vagrant

# make sure inventory files are not executable if the deployment VM
# shared folder comes from a windows workstation vagrant host
chmod a-x inventory/*.ini

# provision this bootstrap VM
$ansible \
  -i 'localhost,' \
  -c local \
  provisioning/bootstrap-011_packages.yml
