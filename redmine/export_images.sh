#!/bin/sh
set -e

DIR_NAME=images

echo "[INFO] Start export images."

echo "[INFO] Exporting git-storage images."
docker export git-storage > ${DIR_NAME}/exp_git-storage.tar
echo "[INFO] Exporting redmine-files images."
docker export redmine-files > ${DIR_NAME}/exp_redmine-files.tar
echo "[INFO] Exporting mariadb-storage images."
docker export mariadb-storage > ${DIR_NAME}/exp_mariadb-storage.tar
echo "[INFO] Exporting redmine images."
docker export redmine > ${DIR_NAME}/exp_redmine.tar
echo "[INFO] Exporting mariadb images."
docker export mariadb > ${DIR_NAME}/exp_mariadb.tar
echo "[INFO] Exporting nginx images."
docker export nginx > ${DIR_NAME}/exp_nginx.tar

echo "[INFO] Finish export images."