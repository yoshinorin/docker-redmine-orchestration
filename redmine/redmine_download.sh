#!/bin/sh

REDMINE_VERSION="3.4.3"
MD5_CHECKSUM="8053592a1259863623824543524e4360"

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
  cp -f config.ru src/config.ru
  rm -rf redmine-${REDMINE_VERSION}
  rm -rf redmine/redmine-${REDMINE_VERSION}
  rm redmine-${REDMINE_VERSION}.tar.gz
else
  echo "[WARN] Doesn't match the check sum."
fi

echo "[INFO] Finish."