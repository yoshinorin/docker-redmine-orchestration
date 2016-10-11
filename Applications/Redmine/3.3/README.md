# (WIP):Redmine 3.3.0 powerd by Docker

* MariaDB
* Nginx
* Unicorn

# Direcroty Hierarchy

.
|-- docker-compose.yml
|-- logs
|   |-- nginx
|   `-- redmine
|-- mariadb
|   |-- config
|   |   `-- my.cnf
|   `-- Dockerfile
|-- nginx
|   |-- Dockerfile
|   `-- nginx.conf
|-- README.md
|-- redmine
|   |-- config
|   |   |-- configuration.yml
|   |   |-- database.yml
|   |   |-- settings.yml
|   |   `-- unicorn.rb
|   |-- config.default
|   |   |-- configuration.yml
|   |   |-- database.yml
|   |   |-- README.md
|   |   `-- settings.yml
|   |-- docker-entrypoint.sh
|   |-- Dockerfile
|   |-- Gemfile
|   |-- README.md
|   |-- redmine_download.sh
|   `-- redmine-download.sh
`-- storage
    |-- mariadb-storage
    |   `-- Dockerfile
    `-- redmine-files
        `-- Dockerfile
