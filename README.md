![Build and Push](https://github.com/binbashing/logrotate-docker/actions/workflows/build-push.yaml/badge.svg)
# Logrotate

A simple docker container based on Alpine the does logrotate.

## Usage

- Use shared volumes to share log files with a container that produces logfiles
- Set `LOGROTATE_PATTERN` etc. to configure what logrotate watches, log file size, etc.

```sh
docker run -it --rm \
  --env CRON_SCHEDULE='' \
  --env LOGROTATE_SIZE=1M \
  --env LOGROTATE_PATTERN=/var/logs/example-app/*.log \
  -v logs:/var/logs/example-app
  binbashing/logrotate
```

## Customization

Most options below are substituted into the config file for logrotate, so please refer to the
[Manpage for logrotate](https://linux.die.net/man/8/logrotate) for detailled documentation.

|Option|Default|Description|
|------|-------|-----------|
|`CRON_SCHEDULE`|`0 * * * *`|Cron schedule for logrotate command|
|`LOGROTATE_SIZE`|`100M`|Maximum size of log files|
|`LOGROTATE_MODE`|`copytruncate`|Mode of log rotation|
|`LOGROTATE_PATTERN`|`/logs/*.log`|Path pattern of log files to manage|
|`LOGROTATE_ROTATE`|`0`|Number of old log files to keep|
