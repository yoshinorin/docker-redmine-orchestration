#!/bin/sh

REDMINE_VERSION="3.4.1"
MD5_CHECKSUM="79b07289c0b591e81180d017dbf6ebf4"

cd $(dirname $0)
echo pwd

/bin/sh ./redmine_download_main.sh ${REDMINE_VERSION} ${MD5_CHECKSUM}