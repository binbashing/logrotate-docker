FROM alpine

# Set environment variables for cron schedule, logrotate size, mode, pattern and rotate
ENV CRON_SCHEDULE='0 * * * *' \
    LOGROATE_INTERVAL='daily' \
    LOGROTATE_SIZE='100M' \
    LOGROTATE_MODE='copytruncate' \
    LOGROTATE_PATTERN='/logs/*.log' \
    LOGROTATE_ROTATE='0' \
    LOGROTATE_COMPRESS='compress'

# Update and upgrade packages
RUN apk update && apk upgrade

# Install necessary packages and create necessary directories
RUN apk add logrotate tini gettext libintl && \
    mkdir -p /logs && \
    mkdir -p /etc/logrotate.d

# Copy logrotate configuration template and entrypoint script into the image
COPY logrotate.tpl.conf /logrotate.tpl.conf
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

# Set the entrypoint script
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

# Set the default command to run cron daemon in the foreground and log to stdout
CMD ["/usr/sbin/crond", "-f", "-L", "/dev/stdout"]