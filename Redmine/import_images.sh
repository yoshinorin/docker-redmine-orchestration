#!/bin/sh
set -e

DIR_NAME=images

echo "[INFO] Start import images."

echo "[INFO] Importing git-storage images."
cat ${DIR_NAME}/exp_git-storage.tar | docker import - dockercomp_git-storage:latest
echo "[INFO] Importing redmine-files images."
cat ${DIR_NAME}/exp_redmine-files.tar | docker import - dockercomp_redmine-files:latest
echo "[INFO] Importing mariadb-storage images."
cat ${DIR_NAME}/exp_mariadb-storage.tar | docker import - dockercomp_mariadb-storage:latest
echo "[INFO] Importing redmine images."
cat ${DIR_NAME}/exp_redmine.tar | docker import - dockercomp_redmine:latest
echo "[INFO] Importing mariadb images."
cat ${DIR_NAME}/exp_mariadb.tar | docker import - dockercomp_mariadb:latest
echo "[INFO] Importing nginx images."
cat ${DIR_NAME}/exp_nginx.tar | docker import - dockercomp_nginx:latest

echo "[INFO] Finish import images."