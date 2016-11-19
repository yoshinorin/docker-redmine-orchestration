# Redmine 

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
|-- README.md
|-- redmine
|   |-- docker-entrypoint.sh
|   |-- Dockerfile
|   |-- Gemfile
|   |-- README.md
|   |-- redmine
|   |   `-- config
|   |       |-- configuration.yml
|   |       |-- database.yml
|   |       |-- settings.yml
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
