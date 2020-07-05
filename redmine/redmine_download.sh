#!/bin/sh

REDMINE_VERSION="4.1.1"
SHA256_CHECKSUM="05faafe764330f2d77b0aacddf9d8ddce579c3d26bb8e03a7d6e7ff461f1cdda"

echo "[INFO] Downloading..."

cd $(dirname $0)
echo pwd

curl -O -s https://www.redmine.org/releases/redmine-${REDMINE_VERSION}.tar.gz

line=`sha256sum redmine-${REDMINE_VERSION}.tar.gz`
set -f
set -- $line

if [ $SHA256_CHECKSUM = $1 ];then
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