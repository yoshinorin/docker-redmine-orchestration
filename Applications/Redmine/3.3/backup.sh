#!/bin/sh
set -e

ROOT_DIR_NAME=backups
SUB_DIR_NAME=`date +%Y%m%d`
FILE_PREFIX=`date +%H%M%S`

echo "[INFO] Start backup."

if [ ! -d ./${ROOT_DIR_NAME}/${SUB_DIR_NAME} ]; then
  mkdir ./${ROOT_DIR_NAME}/${SUB_DIR_NAME}
fi

# TODO : Can create safe backup option (Stop all containers befor backup).
docker run --volumes-from mariadb-storage -v $(pwd)/${ROOT_DIR_NAME}/${SUB_DIR_NAME}/:/${ROOT_DIR_NAME}/${SUB_DIR_NAME}/ \
  dockercomp_mariadb-storage:latest tar cvf /${ROOT_DIR_NAME}/${SUB_DIR_NAME}/${FILE_PREFIX}_data_mariadb.tar /var/lib/mysql

docker run --volumes-from redmine-files -v $(pwd)/${ROOT_DIR_NAME}/${SUB_DIR_NAME}/:/${ROOT_DIR_NAME}/${SUB_DIR_NAME}/ \
  dockercomp_redmine-files:latest tar cvf /${ROOT_DIR_NAME}/${SUB_DIR_NAME}/${FILE_PREFIX}_files_redmine.tar /usr/src/app/redmine/files



#if [ -n $1 ]; then
#  echo "[INFO] Application Container backup."
#  if [ $1 = "-f" ]; then
#    docker export redmine-files > ./${ROOT_DIR_NAME}/`date +%Y%m%d`/`date +%Y%m%d_%H%M%S`_app_nginx.tar.gz
#    docker export mariadb-storage > ./${ROOT_DIR_NAME}/`date +%Y%m%d`/`date +%Y%m%d_%H%M%S`_app_mariadb.tar.gz
#    docker export mariadb-storage > ./${ROOT_DIR_NAME}/`date +%Y%m%d`/`date +%Y%m%d_%H%M%S`_app_redmine.tar.gz
#  else
#    echo "[ERROR] Argument1 is error."
#    echo "-f : full backup."
#  fi
#fi

echo "[INFO] Finish backup."