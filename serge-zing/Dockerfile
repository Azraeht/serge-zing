FROM python:2.7
LABEL maintainer="brice.santus@gmail.com"

EXPOSE 8000

ARG serge_data_dir=/data

# Path to serge settings
ENV SERGE_SETTINGS /etc/serge/serge.conf
# Path to zing settings file
ENV ZING_SETTINGS /root/.zing/zing.conf
# Git server domain for setting up ssh pull/push
ENV GIT_SERVER_DOMAIN github.com
# Serge/Zing working dir
ENV SERGE_DATA_DIR=$serge_data_dir
# Zing DB root password
ENV ZING_DB_ROOT_PASSWORD root

# Install prerequisites
RUN apt-get -qq update && \
    apt-get -qq -y install build-essential libssl-dev libexpat-dev wget unzip mysql-client && \
    apt-get -qq -y install git curl cron
# Install serge
RUN mkdir ~/serge && \
    cd ~/serge && \
    wget https://github.com/evernote/serge/archive/1.3.zip -O serge-1.3.zip && \
    unzip serge-1.3.zip && \
    unlink serge-1.3.zip && \
    cd serge-1.3 && \
    cpan App::cpanminus && \
    cpanm --installdeps . && \
    ln -s ~/serge/serge-1.3/bin/serge /usr/local/bin/serge
# Install Zing
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
    apt-get install -qq -y nodejs && \
    pip install https://github.com/evernote/zing/archive/v0.8.8.zip && \
    pip install MySQL-python==1.2.5

# Add crontab and prepare logs file
ADD ./crontab /etc/cron.d/serge-cron
RUN chmod 0644 /etc/cron.d/serge-cron
RUN mkdir $SERGE_DATA_DIR && \
    touch /var/log/cron.log && \
    touch /var/log/serge.log
# Set entrypoint for managing ssh
COPY ./docker-entrypoint.sh /bin/docker-entrypoint.sh
RUN chmod +x /bin/docker-entrypoint.sh
ENTRYPOINT ["/bin/docker-entrypoint.sh"]
