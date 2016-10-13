#!/bin/sh
set -e

BACKUP_ROOT_DIR_NAME=backups

echo "[INFO] Start backup."

if [ ! -d ./${BACKUP_ROOT_DIR_NAME}/`date +%Y%m%d` ]; then
  mkdir ./${BACKUP_ROOT_DIR_NAME}/`date +%Y%m%d`
fi

# TODO : Can create safe backup option (Stop all containers befor backup).
docker export redmine-files > ./${BACKUP_ROOT_DIR_NAME}/`date +%Y%m%d`/`date +%Y%m%d_%H%M%S`_data_redmine_files.tar.gz
docker export mariadb-storage > ./${BACKUP_ROOT_DIR_NAME}/`date +%Y%m%d`/`date +%Y%m%d_%H%M%S`_data_mariadb.tar.gz

if [ -n $1 ]; then
  echo "[INFO] Application Container backup."
  if [ $1 = "-f" ]; then
    docker export redmine-files > ./${BACKUP_ROOT_DIR_NAME}/`date +%Y%m%d`/`date +%Y%m%d_%H%M%S`_app_nginx.tar.gz
    docker export mariadb-storage > ./${BACKUP_ROOT_DIR_NAME}/`date +%Y%m%d`/`date +%Y%m%d_%H%M%S`_app_mariadb.tar.gz
    docker export mariadb-storage > ./${BACKUP_ROOT_DIR_NAME}/`date +%Y%m%d`/`date +%Y%m%d_%H%M%S`_app_redmine.tar.gz
  else
    echo "[ERROR] Argument1 is error."
    echo "-f : full backup."
  fi
fi

echo "[INFO] Finish backup."