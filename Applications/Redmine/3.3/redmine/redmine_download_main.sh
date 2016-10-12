#!/bin/sh

REDMINE_VERSION=$1
MD5_CHECKSUM=$2

curl -O -s http://www.redmine.org/releases/redmine-${REDMINE_VERSION}.tar.gz

line=`md5sum redmine-${REDMINE_VERSION}.tar.gz`
set -f
set -- $line

if [ $MD5_CHECKSUM = $1 ];then
  tar xvfz redmine-${REDMINE_VERSION}.tar.gz
  mv redmine-${REDMINE_VERSION} redmine
  rm -rf redmine/redmine-${REDMINE_VERSION}
  rm redmine-${REDMINE_VERSION}.tar.gz
else
  echo "doesn't match the check sum."
fi

echo "Downloaded."