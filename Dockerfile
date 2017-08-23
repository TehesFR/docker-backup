FROM alpine:3.6

RUN apk update
RUN apk add python py-pip py-setuptools git ca-certificates mariadb-client zip tzdata
RUN pip install python-dateutil

# Configure tzdata
RUN cp /usr/share/zoneinfo/Europe/Paris /etc/localtime
RUN echo "Europe/Paris" > etc/timezone
RUN apk del tzdata

# Install awscli
RUN pip install --upgrade awscli
RUN mkdir /root/.aws

# Add docker-entrypoint
ADD ./core/docker-entrypoint.sh /opt/docker-entrypoint.sh

# Folders for backups operations
RUN mkdir /opt/bk /opt/www

# Main entrypoint script
RUN chmod 777 /opt/docker-entrypoint.sh && chmod +x /opt/docker-entrypoint.sh

ENTRYPOINT ["/opt/docker-entrypoint.sh"]