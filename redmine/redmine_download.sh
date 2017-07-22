#!/bin/sh

REDMINE_VERSION="3.4.2"
MD5_CHECKSUM="2980b80e9acc81c01c06adb86eb4f37d"

echo "[INFO] Downloading..."

cd $(dirname $0)
echo pwd

curl -O -s http://www.redmine.org/releases/redmine-${REDMINE_VERSION}.tar.gz

line=`md5sum redmine-${REDMINE_VERSION}.tar.gz`
set -f
set -- $line

if [ $MD5_CHECKSUM = $1 ];then
  tar xvfz redmine-${REDMINE_VERSION}.tar.gz
  cp -Rf redmine-${REDMINE_VERSION}/. src
  rm -rf redmine-${REDMINE_VERSION}
  rm -rf redmine/redmine-${REDMINE_VERSION}
  rm redmine-${REDMINE_VERSION}.tar.gz
else
  echo "[WARN] Doesn't match the check sum."
fi

echo "[INFO] Finish."