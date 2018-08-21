FROM python:2.7
MAINTAINER brice.santus@gmail.com

ENV ZING_DB_ROOT_PASSWORD root

EXPOSE 8000

RUN apt-get update && \
    apt-get install -qq -y mysql-client && \
    curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
    apt-get install -qq -y nodejs && \
    pip install https://github.com/evernote/zing/archive/v0.8.8.zip && \
    pip install MySQL-python==1.2.5

# Set entrypoint
COPY docker-entrypoint.sh /bin/docker-entrypoint.sh
RUN chmod +x /bin/docker-entrypoint.sh
ENTRYPOINT ["/bin/docker-entrypoint.sh"]
CMD zing runserver 0.0.0.0:8000 --insecure
