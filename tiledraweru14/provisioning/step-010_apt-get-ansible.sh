#!/bin/bash

echo "tiledraweru14 Provisioning Step 010 - apt-get update and ansible"

ansible=`which ansible-playbook 2>/dev/null`

# stop on error
set -e

if [[ -z $ansible ]]; then
  # need ansible ppa for required 1.9+ version
  sudo apt-get -q -y install software-properties-common
  sudo apt-add-repository -y ppa:ansible/ansible

  # repo update may fail on mapnik, as it has no trusty ppa
  # if it does that's okay
  sudo apt-get -q -y update

  sudo apt-get -q -y upgrade

  sudo apt-get -q -y install git curl htop vim ansible
  hash -r
  ansible=`which ansible-playbook 2>/dev/null`
fi
