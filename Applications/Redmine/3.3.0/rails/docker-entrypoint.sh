#!/bin/sh
set -e

if [ "$RAILS_MIGRATE" = 1 ]; then
  echo `date '+%Y/%m/%d %H:%M:%S'` "[INFO] Start database migrate."
  RAILS_ENV=production bundle exec rake db:migrate /usr/src/app/redmine-3.3.0/Gemfile
  RAILS_ENV=production bundle exec rake assets:precompile
else
  echo `date '+%Y/%m/%d %H:%M:%S'` "[INFO] Non migrate."
fi

echo `date '+%Y/%m/%d %H:%M:%S'` "[INFO] Start unicorn."
SECRET_KEY_BASE=$(rake secret) RAILS_SERVE_STATIC_FILES=true bundle exec unicorn_rails -E production -c /usr/src/app/redmine-3.3.0/config/unicorn.rb -p 3000
