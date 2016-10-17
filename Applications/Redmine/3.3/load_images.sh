#!/bin/sh
set -e

DIR_NAME=images

echo "[INFO] Start create images."

# Official images
echo "[INFO] Loading official busybox images."
docker load < ${DIR_NAME}/official-busybox-uclibc.tar
echo "[INFO] Loading official nginx images."
docker load < ${DIR_NAME}/official-nginx-1.11.5.tar
echo "[INFO] Loading official ruby images."
docker load < ${DIR_NAME}/official-ruby-2.3.1.tar
echo "[INFO] Loading official mariadb images."
docker load < ${DIR_NAME}/official-mariadb-10.1.tar

# Non-official images
echo "[INFO] Loading git-storage images."
docker load < ${DIR_NAME}/git-storage.tar
echo "[INFO] Loading redmine-files images."
docker load < ${DIR_NAME}/redmine-files.tar
echo "[INFO] Loading mariadb-storage images."
docker load < ${DIR_NAME}/mariadb-storage.tar
echo "[INFO] Loading redmine images."
docker load < ${DIR_NAME}/redmine.tar
echo "[INFO] Loading mariadb images."
docker load < ${DIR_NAME}/mariadb.tar
echo "[INFO] Loading nginx images."
docker load < ${DIR_NAME}/nginx.tar

echo "[INFO] Finish create images."