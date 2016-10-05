#based on https://github.com/YoshinoriN/docker-rails/tree/master/ruby-2.3.1
FROM ruby:2.3.1-alpine

MAINTAINER YoshinoriN

ENV REDMINE_VERSION=3.3.0

RUN apk update --no-cache \
  && apk add --no-cache --virtual build-dependencies libffi-dev build-base imagemagick-dev=6.9.5.9-r0 mariadb-dev=10.1.17-r0 \
  && apk add --no-cache mysql-client \
  && mkdir -p /usr/src/app/redmine-${REDMINE_VERSION}

WORKDIR /usr/src/app/redmine-${REDMINE_VERSION}
COPY ./redmine-${REDMINE_VERSION} /usr/src/app/redmine-${REDMINE_VERSION}
COPY ./config/* /usr/src/app/redmine-${REDMINE_VERSION}/config/

RUN gem install ffi -v 1.9.14 \
  && bundle install --without development test

ENV RAILS_ENV production
RUN bundle exec rake db:create \
  && bundle exec rake db:migrate \
  && bundle exec rake assets:precompile \
  && apk del --purge build-dependencies

EXPOSE 3000
CMD ["bundle", "exec", "unicorn", "-c", "config/unicorn.rb", "-b", "0.0.0.0" ]
