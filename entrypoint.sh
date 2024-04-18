#!/bin/sh

set -e

# Set default values for environment variables
envsubst > /etc/logrotate.conf < /logrotate.tpl.conf

# Set up cron schedule
echo "$CRON_SCHEDULE /usr/sbin/logrotate /etc/logrotate.conf" | crontab -

# Run cron in the foreground
exec tini "${@}"
