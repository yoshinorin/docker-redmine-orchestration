FROM ruby:2.6-alpine3.13

MAINTAINER YoshinoriN

RUN apk update --no-cache \
  && apk add --no-cache --virtual build-dependencies libffi-dev build-base \
  && apk add --no-cache mysql-client tzdata mariadb-dev=10.5.9-r0 linux-headers=5.7.8-r0 imagemagick-dev=7.0.10.57-r0 \
  && apk add --no-cache git \
  && mkdir -p /usr/src/app/redmine \
  && mkdir -p /usr/src/app/redmine/tmp/pids

WORKDIR /usr/src/app/redmine
COPY ./src /usr/src/app/redmine
COPY docker-entrypoint.sh /usr/src/app/redmine
COPY Gemfile /usr/src/app/redmine

RUN gem install bundler -v 2.1.4 --no-document \
  && bundle install --jobs=10 --without development test \
  && bundle exec rake generate_secret_token \
  && chmod 0700 docker-entrypoint.sh \
  && apk del --purge build-dependencies \
  && rm -rf /var/cache/apk/*

ENTRYPOINT "/usr/src/app/redmine/docker-entrypoint.sh"

EXPOSE 3000
