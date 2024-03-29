FROM ubuntu:16.04
LABEL maintainer="abel.silva@gmail.com"


RUN apt-get update \
 && apt-get install -y --no-install-recommends \
        curl \
        less \
        ca-certificates-java

RUN export DOWNLOAD_URL="http://launchpadlibrarian.net/505954362/openjdk-8-jre-headless_8u275-b01-0ubuntu1~16.04_amd64.deb" \
  && curl -L ${DOWNLOAD_URL} -o "/tmp/openjdk-8-jre-headless_8u275-b01-0ubuntu1~16.04_amd64.deb" \
  && dpkg -i "/tmp/openjdk-8-jre-headless_8u275-b01-0ubuntu1~16.04_amd64.deb" \
  && rm -f "/tmp/openjdk-8-jre-headless_8u275-b01-0ubuntu1~16.04_amd64.deb"

RUN apt-get install -y --no-install-recommends \
        ca-certificates \
        sudo \
        psmisc \
        lsb-release \
        mongodb-server \
        jsvc \
 && rm -rf /var/lib/apt/lists/*

RUN export DOWNLOAD_URL="https://dl.ui.com/firmwares/ufv/v3.10.13/unifi-video.Ubuntu16.04_amd64.v3.10.13.deb" \
 && curl -L ${DOWNLOAD_URL} -o /tmp/unifi-video.deb \
 && dpkg -i /tmp/unifi-video.deb \
 && rm -f /tmp/unifi-video.deb

RUN export DOWNLOAD_URL="https://dlcdn.apache.org/logging/log4j/2.16.0/apache-log4j-2.16.0-bin.tar.gz" \
 && curl -L ${DOWNLOAD_URL} -o /tmp/log4j.tar.gz \
 && tar -xzvf /tmp/log4j.tar.gz -C /tmp \
 && rm -rf /usr/lib/unifi-video/lib/log4j-api-2.1.jar \
 && rm -rf /usr/lib/unifi-video/lib/log4j-core-2.1.jar \
 && rm -rf /usr/lib/unifi-video/lib/log4j-slf4j-impl-2.1.jar \
 && cp /tmp/apache-log4j-2.16.0-bin/log4j-api-2.16.0.jar /usr/lib/unifi-video/lib/log4j-api-2.1.jar \
 && cp /tmp/apache-log4j-2.16.0-bin/log4j-core-2.16.0.jar /usr/lib/unifi-video/lib/log4j-core-2.1.jar \
 && cp /tmp/apache-log4j-2.16.0-bin/log4j-slf4j-impl-2.16.0.jar /usr/lib/unifi-video/lib/log4j-slf4j-impl-2.1.jar \
 && rm -rf /tmp/log4j.tar.gz /tmp/apache-log4j-2.16.0-bin

RUN sed -i 's/ulimit.*$//g' /usr/sbin/unifi-video

ADD start.sh /srv/bin/start.sh
RUN chmod +x /srv/bin/start.sh

EXPOSE 6666 7080 7442 7443 7445 7446 7447
VOLUME /srv/unifi-video

WORKDIR /srv/unifi-video
CMD ["/srv/bin/start.sh"]

