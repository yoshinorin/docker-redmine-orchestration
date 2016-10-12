#!/bin/sh
set +e

# Confirm connection.
# TODO : Break infinit roop, if passed few minites.
if [ -n "$DB_PING_USER" ]; then
  echo `date '+%Y/%m/%d %H:%M:%S'` $0 "[INFO] Connection confriming..."
  while :
  do
    result=`/usr/bin/mysqladmin ping -h mariadb -u${DB_PING_USER} -p${DB_PING_USER_PASSWORD}`
    if echo $result|grep 'alive'; then
      break
    fi
    sleep 10;
  done
fi

set -e
# Migrate database of Redmine.
if [ "$RAILS_MIGRATE" = 1 ]; then
  echo `date '+%Y/%m/%d %H:%M:%S'` $0 "[INFO] Start database migrate."
  RAILS_ENV=production bundle exec rake db:migrate /usr/src/app/redmine/Gemfile
  RAILS_ENV=production bundle exec rake assets:precompile
else
  echo `date '+%Y/%m/%d %H:%M:%S'` $0 "[INFO] Non migrate."
fi

# Remove unicorn pid.
if [ -e /usr/src/app/redmine/tmp/pids/unicorn.pid ]; then
  rm /usr/src/app/redmine/tmp/pids/unicorn.pid
fi

# Run unicorn.
echo `date '+%Y/%m/%d %H:%M:%S'` $0 "[INFO] Start unicorn."
SECRET_KEY_BASE=$(rake secret) RAILS_SERVE_STATIC_FILES=true bundle exec unicorn_rails -E production -c /usr/src/app/redmine/config/unicorn.rb -p 3000
