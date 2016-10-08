#based on https://github.com/YoshinoriN/docker-rails/tree/master/ruby-2.3.1
FROM ruby:2.3.1-alpine

MAINTAINER YoshinoriN

ENV REDMINE_VERSION=3.3.0

RUN apk update --no-cache \
  && apk add --no-cache --virtual build-dependencies libffi-dev build-base imagemagick-dev=6.9.5.9-r0 mariadb-dev=10.1.17-r0 linux-headers=4.4.6-r1 \
  && apk add --no-cache mysql-client tzdata \
  && mkdir -p /usr/src/app/redmine-${REDMINE_VERSION}

WORKDIR /usr/src/app/redmine-${REDMINE_VERSION}
COPY ./redmine-${REDMINE_VERSION} /usr/src/app/redmine-${REDMINE_VERSION}
COPY ./config/* /usr/src/app/redmine-${REDMINE_VERSION}/config/

RUN gem install ffi -v 1.9.14 --no-rdoc --no-ri \
  && gem install unicorn -v 5.1.0 --no-rdoc --no-ri \
  && gem install bundler --no-rdoc --no-ri \
  && gem install tzinfo-data --no-rdoc --no-ri \
  && bundle install --jobs=10 --without development test \
  && bundle exec rake generate_secret_token

ENTRYPOINT RAILS_ENV=production bundle exec rake db:migrate /usr/src/app/redmine-3.3.0/Gemfile

#RUN apk del --purge build-dependencies

EXPOSE 3000
