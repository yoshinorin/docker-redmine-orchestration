#!/bin/sh

REDMINE_VERSION="4.2.0"
SHA256_CHECKSUM="295864c580afa2a926e7a17f2ad10693f9b7a6d9f1ef523edb96b2368e7f07e5"

echo "[INFO] Downloading..."

cd $(dirname $0)

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