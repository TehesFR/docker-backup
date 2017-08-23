#!/bin/sh

# Copy secret awscli config file 
if [ -f /run/secrets/awscli_config ]; then
   echo "Using secret awscli_config"
   cp /run/secrets/awscli_config /root/.aws/config
else
   echo "No awscli_config secret provided"
fi

# Copy secret awscli credentials file 
if [ -f /run/secrets/awscli_credentials ]; then
   echo "Using secret awscli_credentials"
   cp /run/secrets/awscli_credentials /root/.aws/credentials
else
   echo "No awscli_credentials secret provided"
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

# Keep the container alive running cron daemon
crond -f