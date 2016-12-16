# Redmine 

[日本語はこちら](/doc/README_JA.md)

# CI

|Build|
|---|
|![](https://circleci.com/gh/YoshinoriN/docker-redmine-orchestration/tree/master.svg?style=shield&circle-token=e925c3a7ecef92d882d354a82464d4b7e309c004)|

# Architecture

* MariaDB 10.1
* Nginx 1.11.6
* Ruby 2.3.1
* Unicorn 5.1.0

# what is difference between official docker-redmine ?

||Official|This application|
|---|---|---|
|DB|MySQL|MariaDB|
|Web server|webrick or passenger|Nginx|
|Rails server|webrick or passenger|unicorn|

# Requirements

* Higher than Docker compose 1.6

# Overview

![](./doc/img/overview.png)

# Default installed VCS

The git were installed in the Redmine container and the Redmine's `configuration.yml` has been already setted up to link git.

# Install and execute

## Install

* At first. Download Redmine's source code using by `*_download.sh`. You can select which version of Redmine use.

* Second. Please change Redmine's setting.
    * Redmine's setting files are contain in the `Redmine/redmine/config` directory.

## Docker compose up

Please execute below command on `redmine` directory.

```sh
docker-compose up
```

After first build, please change `RAILS_MIGRATE` value to `0` in the `docker-compose.yml`.

# Direcroty Hierarchy

```sh

.
|-- doc
|   |-- img
|   |   `-- overview.png
|   |-- overview.pptx
|   `-- README_JA.md
|-- README.md
`-- redmine
    |-- backups
    |-- backup.sh
    |-- create_images.sh
    |-- docker-compose.yml
    |-- export_images.sh
    |-- images
    |-- import_images.sh
    |-- load_images.sh
    |-- logs
    |   |-- nginx
    |   `-- redmine
    |-- mariadb
    |   |-- config
    |   |   `-- my.cnf
    |   `-- Dockerfile
    |-- nginx
    |   |-- config
    |   |   `-- nginx.conf
    |   `-- Dockerfile
    |-- redmine
    |   |-- docker-entrypoint.sh
    |   |-- Dockerfile
    |   |-- Gemfile
    |   |-- README.md
    |   |-- redmine
    |   |   `-- config
    |   |       |-- configuration.yml
    |   |       |-- database.yml
    |   |       `-- unicorn.rb
    |   |-- redmine_3.3.0_download.sh
    |   |-- redmine_3.3.1_download.sh
    |   `-- redmine_download_main.sh
    `-- storage
        |-- git-storage
        |   |-- Dockerfile
        |   `-- repositories
        |       `-- README.md
        |-- mariadb-storage
        |   |-- data
        |   `-- Dockerfile
        `-- redmine-files
            |-- Dockerfile
            `-- files
```
