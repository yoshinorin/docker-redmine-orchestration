#!/bin/sh

REDMINE_VERSION="3.3.2"
MD5_CHECKSUM="8e403981dc3a19a42ee978f055be62ca"

cd $(dirname $0)
echo pwd

/bin/sh ./redmine_download_main.sh ${REDMINE_VERSION} ${MD5_CHECKSUM}