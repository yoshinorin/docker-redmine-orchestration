![](https://img.shields.io/badge/Redmine-v4.2.0-blue.svg)

# docker-redmine-orchestration 

A easy and fast docker-compose for Redmine (Nginx + Unicorn + MariaDB)

[日本語はこちら](/doc/README_JA.md)

# Architecture

* MariaDB 10.5.x
* Nginx 1.19 (Also you can ignore it)
* Ruby 2.4.1
* Unicorn 5.5.5

# what is difference between official docker-redmine ?

|-|Official|This application|
|---|---|---|
|DB|MySQL|MariaDB|
|Web server|-|Nginx (Also you can ignore it)|
|Application server|webrick or passenger|unicorn (Include unicorn worker killer)|
|Version Control System|-|Bundled with git|

# Requirements

* Higher than Docker compose 3

# Overview

![](./doc/img/overview.png)

# Default installed VCS

The git were installed in the Redmine container and the Redmine's `configuration.yml` has been already setted up to link git.

# Install and execute

## Install

* At first. Download Redmine's source code using by `./redmine/redmine_download.sh`.

* Second. Please change Redmine's setting.
    * Redmine's setting files are contain in the `./redmine/src/config` directory.

## Docker compose up

Please execute `docker-compose up` in root directory.

```sh
docker-compose up
```

Please access `http://yourdomain:3000`.

After first build, please change `RAILS_MIGRATE` value to `0` in the `docker-compose.yml`.

# Settings

## MariaDB

Please change `./mariadb/config/my.cnf`.
Also you can change it after build image.

### Character set

Default character set is `utf8mb4`.

### User and password

**User and paswword are decided when build docker image.** You can specify user and password using by `docker-compose.yml`.

```yml
  mariadb:
    build: ./mariadb
    container_name: mariadb
    environment:
      MYSQL_ROOT_PASSWORD: mypass
      MYSQL_USER: redmine
      MYSQL_DATABASE: redmine
```

You can remove `MYSQL_ROOT_PASSWORD` key in `docker-compose.yml`, after first docker image build.

If you change `MYSQL_USER` and `MYSQL_DATABASE`. You have to change `./redmine/src/config/database.yml` and `DB_PING_USER` and `DB_PING_USER_PASSWORD`.

```yml
  redmine:
    build: ./redmine
    container_name: redmine
    environment:
      RAILS_MIGRATE: 1
      PLUGINS_MIGRATE: 1
      DB_PING_USER: redmine
      DB_PING_USER_PASSWORD: redmine 
```
Redmine container have to start after MariaDB container. So,
`DB_PING_USER` and `DB_PING_USER_PASSWORD` are wait to start MariaDB container.

### Directory connecting

The default setting you can't connect MariaDB directly.
If you want to connect directly, please add below key in `mariadb` key.

```yml
    ports:
      - "3306:3306"
```

You can connect MariaDB directory using by `3306` port. Also you can change port number.

## nginx

Please change `./nginx/config/nginx.conf`.
Also you can change it after build image.

### Ignore nginx

If you want ingnore nginx (for example you have already use other webserver.) please commented out `nginx` key in `docker-compose.yml`.
And add below key in `redmine` key.

```yml
    ports:
      - "3000:3000"
```

### HTTPS

You have to change `./nginx/config/nginx.conf` and `docker-compose.yml`.

At first please configure `./nginx/config/nginx.conf`.
And change server settings. Below is example.

```yml
server {
        #NOTE : for TLS connection.
        ssl on;
        ssl_prefer_server_ciphers on;
        ssl_protocols TLSv1.2;
        ssl_certificate <key's path in nginx container>
        ssl_certificate_key <key's path in nginx container>
```

Next please change `docker-compose.yml`. You have to put key on **host** machine. And mount these keys on nginx container. So you have to specify host key's path and mount volume path in `docker-compose.yml`.

```yml
    #NOTE : TLS key's path for HTTPS
     - <host ssl_certificate key's path> : <nginx.conf ssl_certificate key's path>
     - <host ssl_certificate_key key's path> : <nginx.conf  ssl_certificate_key key's path>
```

Please change Redmine connection settings to HTTPS using by Redmine's management console.

## Redmine

Please change `./redmine/src/config`.
Also you can change it after build image.

### Install plugins

Please put plugins in the `./redmine/src/plugins` directory.

And please set `PLUGINS_MIGRATE` key's value to `1`.

```yml
  redmine:
    build: ./redmine
    container_name: redmine
    environment:
      RAILS_MIGRATE: 1
      PLUGINS_MIGRATE: 1
```

After that these plugins were installed 

All plugins will install every time when docker compose up. This behavior for flexible install. (User can select what plugin do you use and uninstall every time easily. On the other hand, plugins install when every time starts docker. But, theses process is no effect on data.)

# Unicorn server

You can configure unicorn server settings using by `docker-compose.yml` below directive.

|NAME|PORPOSE|VALUE(DEFAULT)|
|---|---|---|
|UNICORN_WORKER_PROCESS|Number of unicorn worker processes|2|
|UNICORN_TIMEOUT|Timeout|60|
|UNICORN_WOKER_KILLER_MEMORY_MIN|Memory min threshold. Unit is MB.|192|
|UNICORN_WOKER_KILLER_MEMORY_MAX|Memory max threshold. Unit is MB.|256|
|UNICORN_WOKER_KILLER_CHECK_CYCLE|Unicorn worker killer check cycle.|16|
|UNICORN_WOKER_KILLER_VERBOSE|Unicorn worker killer logging.|false|

About unicorn-worker-killer settings, please see [unicorn-worker-killer repository](https://github.com/kzk/unicorn-worker-killer).

# Container's time zone

If you want to change container's time zone. Please add `TZ` key to each container using by `docker-compose.yml`.

Below is example.

```yml
  mariadb-storage:
    build: ./storage/mariadb-storage
    container_name: mariadb-storage
    environment:
      TZ: Asia/Tokyo
    volumes:
     - ./storage/mariadb-storage/data:/var/lib/mysql
```

# git

If you integrate git repositories with Redmine. Please create repositories below directory.

You can create some repositories in the directory.

```sh
./storage/git-storage/repositories/<your-repository>
```

And above directory are mount below directory in Redmine container.

```sh
/usr/src/git/<your-repository>
```

# Back up

Please execute `backup.sh`. Back up files are create in `buckups` directory by `tar` format.

# Others

You can customize other settings using by `docker-compose.yml`

# Direcroty Hierarchy

```sh
.
├── backups
├── backup.sh
├── circle.yml
├── doc
│   ├── img
│   │   └── overview.png
│   ├── overview.pptx
│   └── README_JA.md
├── docker-compose.yml
├── images
├── LICENSE
├── logs
│   ├── nginx
│   └── redmine
├── mariadb
│   ├── config
│   │   └── my.cnf
│   └── Dockerfile
├── nginx
│   ├── config
│   │   └── nginx.conf
│   └── Dockerfile
├── README.md
├── redmine
│   ├── docker-entrypoint.sh
│   ├── Dockerfile
│   ├── Gemfile
│   ├── README.md
│   ├── redmine_download.sh
│   └── src
│       └── config
│           ├── configuration.yml
│           ├── database.yml
│           └── unicorn.rb
└── storage
    ├── git-storage
    │   └── repositories
    │       └── README.md
    ├── mariadb-storage
    │   └── data
    └── redmine-files
        └── files
```
