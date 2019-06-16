FROM ubuntu:16.04
LABEL maintainer="abel.silva@gmail.com"

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
        curl \
        less \
        ca-certificates \
        sudo \
        psmisc \
        lsb-release \
        mongodb-server \
        openjdk-8-jre-headless \
        jsvc \
 && rm -rf /var/lib/apt/lists/*

RUN export DOWNLOAD_URL="https://dl.ubnt.com/firmwares/ufv/v3.10.5/unifi-video.Ubuntu16.04_amd64.v3.10.5.deb" \
 && curl -L ${DOWNLOAD_URL} -o /tmp/unifi-video.deb \
 && dpkg -i /tmp/unifi-video.deb \
 && rm -f /tmp/unifi-video.deb

RUN sed -i 's/ulimit.*$//g' /usr/sbin/unifi-video

ADD start.sh /srv/bin/start.sh
RUN chmod +x /srv/bin/start.sh

EXPOSE 6666 7080 7442 7443 7445 7446 7447
VOLUME /srv/unifi-video

WORKDIR /srv/unifi-video
CMD ["/srv/bin/start.sh"]

