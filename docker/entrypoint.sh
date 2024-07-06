#!/bin/bash
set -e


# Function to check MySQL availability
# function mysql_ready() {
#   mysqladmin ping --host="$DB_HOST" --user="$DB_USERNAME" --password="$DB_PASSWORD" > /dev/null 2>&1
# }

# # Wait until MySQL is ready
# while !(mysql_ready)
# do
#   echo "Waiting for MySQL to be ready..."
#   sleep 3
# done

# Remove a potentially pre-existing server.pid for Rails.
rm -f /rails/tmp/pids/server.pid

# Run database migrations
bundle exec rails db:migrate

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"
