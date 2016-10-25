#!/bin/sh
set -e

DIR_NAME=images
IMAGE_BASE_NAME=`basename $(pwd) | tr -d "-"`

echo "[INFO] Start create images."

# Official images
echo "[INFO] Creating official busybox images."
docker save busybox:uclibc > ${DIR_NAME}/official-busybox-uclibc.tar
echo "[INFO] Creating official nginx images."
docker save nginx:1.11.5 > ${DIR_NAME}/official-nginx-1.11.5.tar
echo "[INFO] Creating official ruby images."
docker save ruby:2.3.1-alpine > ${DIR_NAME}/official-ruby-2.3.1.tar
echo "[INFO] Creating official mariadb images."
docker save mariadb:10.1 > ${DIR_NAME}/official-mariadb-10.1.tar

# Non-official images
echo "[INFO] Creating git-storage images."
docker save ${IMAGE_BASE_NAME}_git-storage:latest > ${DIR_NAME}/git-storage.tar
echo "[INFO] Creating redmine-files images."
docker save ${IMAGE_BASE_NAME}_redmine-files:latest > ${DIR_NAME}/redmine-files.tar
echo "[INFO] Creating mariadb-storage images."
docker save ${IMAGE_BASE_NAME}_mariadb-storage:latest > ${DIR_NAME}/mariadb-storage.tar
echo "[INFO] Creating redmine images."
docker save ${IMAGE_BASE_NAME}_redmine:latest > ${DIR_NAME}/redmine.tar
echo "[INFO] Creating mariadb images."
docker save ${IMAGE_BASE_NAME}_mariadb:latest > ${DIR_NAME}/mariadb.tar
echo "[INFO] Creating nginx images."
docker save ${IMAGE_BASE_NAME}_nginx:latest > ${DIR_NAME}/nginx.tar

echo "[INFO] Finish create images."