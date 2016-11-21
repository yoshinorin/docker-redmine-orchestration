# Redmine 

[日本語はこちら](/doc/README_JA.md)

# CI

|Build|
|---|
|[![CircleCI](https://circleci.com/gh/YoshinoriN/docker-redmine-orchestration.svg?style=svg)](https://circleci.com/gh/YoshinoriN/docker-redmine-orchestration)|

# Architecture

* MariaDB
* Nginx
* Unicorn

# Overview

![](./doc/img/overview.png)

# Default install VCS

* git

# Direcroty Hierarchy

```sh

.
|-- doc
|   |-- img
|   |   `-- overview.png
|   |-- overview.pptx
|   `-- README_JA.md
|-- README.md
`-- Redmine
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
