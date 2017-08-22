#!/bin/sh

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/s3cmd"
mkdir /test
# Copy secret s3cfg file over to the default location where S3cmd is looking for the config file
if [ -f /run/secrets/s3cfg ]; then
   echo "Using secret s3cfg"
   cp /run/secrets/s3cfg /root/.s3cfg
else
   echo "No s3cfg secret provided"
fi

# Copy secret my.cnf file for mysqldump
if [ -f /run/secrets/my.cnf ]; then
   echo "Using secret my.cnf"
   cp /run/secrets/my.cnf /root/.my.cnf
   chmod 600 /root/.my.cnf
else
   echo "No my.cnf secret provided"
fi

# Installing crontab using secret
if [ -f /run/secrets/crontab ]; then
   echo "Using secret crontab"
   cp /run/secrets/crontab /root/cron
   crontab /root/cron
   rm /root/cron
else
   echo "No crontab secret provided"
fi

tail -f /dev/null