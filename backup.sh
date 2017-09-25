#!/bin/sh
set -e

ROOT_DIR_NAME=backups
SUB_DIR_NAME=`date +%Y%m%d`
FILE_PREFIX=`date +%H%M%S`
IMAGE_BASE_NAME=`basename $(pwd) | tr -d "-"`

echo "[INFO] Start backup."

if [ ! -d ./${ROOT_DIR_NAME}/${SUB_DIR_NAME} ]; then
  mkdir ./${ROOT_DIR_NAME}/${SUB_DIR_NAME}
fi

# TODO : Can create safe backup option (Stop all containers befor backup).
sudo docker run --volumes-from mariadb-storage -v $(pwd)/${ROOT_DIR_NAME}/${SUB_DIR_NAME}/:/${ROOT_DIR_NAME}/${SUB_DIR_NAME}/ \
  ${IMAGE_BASE_NAME}_mariadb-storage:latest tar cvf /${ROOT_DIR_NAME}/${SUB_DIR_NAME}/${FILE_PREFIX}_data_mariadb.tar /var/lib/mysql

sudo docker run --volumes-from redmine-files -v $(pwd)/${ROOT_DIR_NAME}/${SUB_DIR_NAME}/:/${ROOT_DIR_NAME}/${SUB_DIR_NAME}/ \
  ${IMAGE_BASE_NAME}_redmine-files:latest tar cvf /${ROOT_DIR_NAME}/${SUB_DIR_NAME}/${FILE_PREFIX}_files_redmine.tar /usr/src/app/redmine/files

sudo docker run --volumes-from git-storage -v $(pwd)/${ROOT_DIR_NAME}/${SUB_DIR_NAME}/:/${ROOT_DIR_NAME}/${SUB_DIR_NAME}/ \
  ${IMAGE_BASE_NAME}_git-storage:latest tar cvf /${ROOT_DIR_NAME}/${SUB_DIR_NAME}/${FILE_PREFIX}_git_repositories.tar /usr/src/git

echo "[INFO] Finish backup."
