FROM ubuntu:xenial
MAINTAINER brice.santus@gmail.com

ARG serge_data_dir=/data
ENV GIT_SERVER_DOMAIN github.com
ENV SERGE_DATA_DIR=$serge_data_dir

# install prerequisites
RUN apt-get -qq update && \
    apt-get -qq -y install build-essential libssl-dev libexpat-dev wget unzip  && \
    apt-get -qq -y install git
# install serge
RUN mkdir ~/serge && \
    cd ~/serge && \
    wget https://github.com/evernote/serge/archive/1.3.zip -O serge-1.3.zip && \
    unzip serge-1.3.zip && \
    unlink serge-1.3.zip && \
    cd serge-1.3 && \
    cpan App::cpanminus && \
    cpanm --installdeps . && \
    ln -s ~/serge/serge-1.3/bin/serge /usr/local/bin/serge
# Add crontab and prepare logs file
ADD crontab /etc/cron.d/serge-cron
RUN mkdir $SERGE_DATA_DIR && \
    touch /var/log/serge.log
# Set entrypoint for managing ssh
COPY docker-entrypoint.sh /bin/docker-entrypoint.sh
RUN chmod +x /bin/docker-entrypoint.sh
ENTRYPOINT ["/bin/docker-entrypoint.sh"]
# define default cmd
CMD cron && tail -f /var/log/cron.log
