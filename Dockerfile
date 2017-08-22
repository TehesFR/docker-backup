FROM alpine:3.6

RUN apk update
RUN apk add python py-pip py-setuptools git ca-certificates mariadb-client zip tzdata
RUN pip install python-dateutil

# Configure tzdata
RUN cp /usr/share/zoneinfo/Europe/Paris /etc/localtime
RUN echo "Europe/Paris" > etc/timezone
RUN apk del tzdata

# Install s3cmd
RUN git clone https://github.com/s3tools/s3cmd.git /opt/s3cmd
RUN ln -s /opt/s3cmd/s3cmd /usr/bin/s3cmd

# Add docker-entrypoint
ADD ./core/docker-entrypoint.sh /opt/docker-entrypoint.sh

# Folders for backups operations
RUN mkdir /opt/bk /opt/www

# Main entrypoint script
RUN chmod 777 /opt/docker-entrypoint.sh && chmod +x /opt/docker-entrypoint.sh

CMD ["/opt/docker-entrypoint.sh"]
ENTRYPOINT ["/bin/sh"]