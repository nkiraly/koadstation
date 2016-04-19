#!/bin/bash

echo "dbdevu14 Provisioning Step 010 - apt-get update and ansible"

ansible=`which ansible-playbook 2>/dev/null`

# stop on error
set -e

if [[ -z $ansible ]]; then
  # need ansible ppa for required 1.9+ version
  sudo apt-get -q -y install software-properties-common
  sudo apt-add-repository -y ppa:ansible/ansible

  # see https://wiki.postgresql.org/wiki/Apt
  sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
  sudo apt-get install wget ca-certificates
  wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

  # https://dev.mysql.com/doc/mysql-apt-repo-quick-guide/en/
  #wget --quiet -O mysql-apt-config_0.7.2-1_all.deb http://dev.mysql.com/get/mysql-apt-config_0.7.2-1_all.deb
  #sudo dpkg -i mysql-apt-config_0.7.2-1_all.deb

  # install latest redis
  sudo echo "deb http://packages.dotdeb.org squeeze all" >  /etc/apt/sources.list.d/dotdeb.org.list
  sudo echo "deb-src http://packages.dotdeb.org squeeze all"  >> /etc/apt/sources.list.d/dotdeb.org.list
  wget -q -O - http://www.dotdeb.org/dotdeb.gpg | sudo apt-key add -

  sudo apt-get -q -y update

  sudo apt-get -q -y upgrade

  sudo apt-get -q -y install git curl htop vim ansible

  # need libhiredis for redis_fdw build
  sudo apt-get -q -y install libhiredis-dev

  hash -r
  ansible=`which ansible-playbook 2>/dev/null`
fi
