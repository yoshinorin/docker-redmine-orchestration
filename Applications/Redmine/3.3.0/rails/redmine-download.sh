#!/bin/sh

REDMINE_VERSION="3.3.0"
MD5_CHECKSUM="0c0abb2d4efde455c3505d8caf01cb2d"

curl -O -s http://www.redmine.org/releases/redmine-${REDMINE_VERSION}.tar.gz

line=`md5sum redmine-${REDMINE_VERSION}.tar.gz`
set -f
set -- $line

if [ $MD5_CHECKSUM = $1 ];then
  tar xvfz redmine-${REDMINE_VERSION}.tar.gz
  mv redmine-${REDMINE_VERSION} redmine
  rm redmine-${REDMINE_VERSION}.tar.gz
else
  echo "doesn't match the check sum."
fi
