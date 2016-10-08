#!/bin/sh
set -e

if [ "$RAILS_MIGRATE" = 1 ]; then
  echo "Start migrate."
  RAILS_ENV=production bundle exec rake db:migrate /usr/src/app/redmine-3.3.0/Gemfile
  RAILS_ENV=production bundle exec rake assets:precompile
fi
