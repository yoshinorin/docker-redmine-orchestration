#!/bin/sh
set -e

DIR_NAME=images
IMAGE_BASE_NAME=`basename $(pwd) | tr -d "-"`

echo "[INFO] Start import images."

echo "[INFO] Importing git-storage images."
cat ${DIR_NAME}/exp_git-storage.tar | docker import - ${IMAGE_BASE_NAME}_git-storage:latest
echo "[INFO] Importing redmine-files images."
cat ${DIR_NAME}/exp_redmine-files.tar | docker import - ${IMAGE_BASE_NAME}_redmine-files:latest
echo "[INFO] Importing mariadb-storage images."
cat ${DIR_NAME}/exp_mariadb-storage.tar | docker import - ${IMAGE_BASE_NAME}_mariadb-storage:latest
echo "[INFO] Importing redmine images."
cat ${DIR_NAME}/exp_redmine.tar | docker import - ${IMAGE_BASE_NAME}_redmine:latest
echo "[INFO] Importing mariadb images."
cat ${DIR_NAME}/exp_mariadb.tar | docker import - ${IMAGE_BASE_NAME}_mariadb:latest
echo "[INFO] Importing nginx images."
cat ${DIR_NAME}/exp_nginx.tar | docker import - ${IMAGE_BASE_NAME}_nginx:latest

echo "[INFO] Finish import images."