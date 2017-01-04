# 補足記事

このリポジトリの補足記事は[こちらです](https://yoshinorin.net/2017/01/04/redmine-based-on-nginx-unicorn-mariadb-using-by-docker-compose/)

# これは何？

Docker-composeで構築できるRedmineです。
公式のDocker Redmineもありますが、公式のRedmineは1コンテナ内で動作することと構成に納得いかない点があったため自作しました。

# CI

|Build|
|---|
|![](https://circleci.com/gh/YoshinoriN/docker-redmine-orchestration/tree/master.svg?style=shield&circle-token=e925c3a7ecef92d882d354a82464d4b7e309c004)|

# 構成

* MariaDB 10.1
* Nginx 1.11.6
* Ruby 2.3.1
* Unicorn 5.1.0

Redmineはダウンロード用のシェルスクリプトによって動作バージョンを変更できるようにしています。

# Docker公式のRedmineとの相違点

||公式|本リポジトリ|
|---|---|---|
|DB|MySQL|MariaDB|
|Webサーバー|webrickもしくはpassenger|Nginx|
|Railsサーバー|webrickもしくはpassenger|unicorn|

その他の相違点は確認していません。

# 動作要件

* Docker compose 1.6以上

# 概要

![](./img/overview.png)


# デフォルトVCS

デフォルトでRedmineコンテナにgitをインストールするようにしています。併せて、Redmineの`configuration.yml`にも自動でgitを紐づけるように設定しています。

# インストールと実行

## インストール

`Redmine/redmine`ディレクトリ内にある`*_download.sh`を実行してください。バージョンに応じたRedmineのソースコードのダウンロードがはじまります。

ダウンロード完了後は`Redmine/redmine/config`内の各種設定ファイルを任意の設定に変更してください。

## 実行

`redmine`ディレクトリ内で下記のコマンドを実行してください。

```sh
docker-compose up
```

`docker-compose.yml`に`RAILS_MIGRATE`というキーが存在します。これは初回ビルド時にデータベースのマイグレートを行うためのものです。初回のビルド後はこちらの値を`0`に変更してください。

# 設定

## MariaDB

MariaDBそのものの設定に関しては`Redmine/mariadb/config/my.cnf`を変更することでコンテナ側に反映されます。
ビルド後も変更可能です。

ただし、ユーザーやパスワードはビルド時に`docker-compose.yml`で作成されます。

### 文字コード

MariaDBの文字コードはUTF-8に設定しています。

### ユーザーとパスワード

`docker-compose.yml`の下記を変更することでユーザーとパスワードを変更することが可能です。

```yml
  mariadb:
    build: ./mariadb
    container_name: mariadb
    environment:
      MYSQL_ROOT_PASSWORD: mypass
      MYSQL_USER: redmine
      MYSQL_DATABASE: redmine
```

変更した場合はあわせて`Redmine/redmine/config/database.yml`も変更してください。初回のビルド後は`MYSQL_ROOT_PASSWORD`は削除可能です。

加えて下記も変更してください。下記はDocker composeで起動した際にMariaDBが先に起動するのを確認するためにpingを打っています。

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

### MariaDBに直接接続したい場合

デフォルトの設定ではMariaDBには直接接続できません。
接続する場合は`docker-compose.yml`の`mariadb`キー内に下記を追記してください。

```yml
    ports:
      - "3306:3306"
```

## Nginx

`Redmine/nginx/config/nginx.conf`を変更することでコンテナ側に反映されます。
ビルド後も変更可能です。

### HTTPS

HTTPSを設定する場合は`Redmine/nginx/config/nginx.conf`と`docker-compose.yml`の2ファイルを修正する必要があります。
証明書はホストOS側に設置し、Nginxコンテナにマウントさせます。

まず、`Redmine/nginx/config/nginx.conf`内の下記コメントアウトを外したうえで、各パラメーターに適切な値と証明書のパスを設定してください。

```sh
server {
        #NOTE : for TLS connection.
        ssl on;
        ssl_prefer_server_ciphers on;
        ssl_protocols TLSv1.2;
        ssl_certificate <key's path in nginx container>;
        ssl_certificate_key <key's path in nginx container>;
```

次に`docker-compose.yml`の次の項目にホスト側の証明書のパスと前述の`nginx.conf`に記述したNginx側の証明書のパスを設定してください。

```yml
    #NOTE : TLS key's path for HTTPS
     - <host ssl_certificate key's path> : <nginx.conf ssl_certificate key's path>
     - <host ssl_certificate_key key's path> : <nginx.conf  ssl_certificate_key key's path>
```

後はRedmine側の管理画面でHTTPS通信に変更してください、

以上でHTTPSで通信できるはずです。

## Redmine

`Redmine/redmine/redmine/config`内の各設定ファイルを変更することでコンテナ側に反映されます。
ビルド後も変更可能です。

### Redmineプラグインをインストールする場合

`Redmine/redmine/redmine/plugins`内にpluginを配置してください。

その後は下記の`PLUGINS_MIGRATE`を`1`に設定してください。コンテナ起動と同時にプラグインのインストールがはじまります。

```yml
  redmine:
    build: ./redmine
    container_name: redmine
    environment:
      RAILS_MIGRATE: 1
      PLUGINS_MIGRATE: 1
      DB_PING_USER: root
      DB_PING_USER_PASSWORD: mypass 
```

前述の通り`RAILS_MIGRATE`キーと`RAILS_MIGRATE`キーが存在します。両方を`1`に設定していると次回以降の起動時にエラーが発生します。初回のビルド後は`RAILS_MIGRATE`キーを`0`に切り替えてください。

なお、ユーザーが使用するプラグインを柔軟にインストールできるように、コンテナ起動時に都度インストールするようにしています。これにより、インストールのたびにイメージを再作成する手間を省いています。

# タイムゾーン

コンテナのタイムゾーンを変更したい場合は下記のように`TZ`キーを追加してください。下記のサンプルだと東京にしています。

```yml
  mariadb-storage:
    build: ./storage/mariadb-storage
    container_name: mariadb-storage
    environment:
      TZ: Asia/Tokyo
    volumes:
     - ./storage/mariadb-storage/data:/var/lib/mysql
```

# その他の設定

その他設定変更したい場合は`docker-compose.yml`を変更してください。

# git

下記のディレクトリにリポジトリを作成した場合にリポジトリをRedmine側のコンテナにマウントするように設定しています。

リポジトリは複数作成可能です。

```sh
Redmine/storage/git-storage/repositories/<your-repository>
```

Redmineコンテナ側のリポジトリのパスは下記のディレクトリ内になります。

```sh
/usr/src/git/<your-repository>
```


# バックアップ

`backup.sh`を実行することで`buckups`ディレクトリ内に「gitリポジトリ/Redmineのfile/MariaDBのデータベース一式」がtar形式で保存されます。

MariaDBに関しては現状データベースファイルが丸ごとバックアップされます。Redmineデータベースのみのバックアップスクリプトは作成予定です。

# その他スクリプト

下記4つのスクリプトは一応動作しますが、正常にエクスポート/インポート/生成/ロードできるか確認できていません。

* export_images.sh
* import_images.sh
* create_images.sh
* load_images.sh

# リポジトリの構成

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
