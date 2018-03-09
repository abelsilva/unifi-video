#!/bin/sh

# Unifi Video directories
mkdir -p /var/cache/unifi-video
chown unifi-video:unifi-video /var/cache/unifi-video
mkdir -p /var/run/unifi-video
chown unifi-video:unifi-video /var/run/unifi-video
mkdir -p /srv/unifi-video/logs
chown unifi-video:unifi-video /srv/unifi-video
chown unifi-video:unifi-video /srv/unifi-video/logs
rm -f /usr/lib/unifi-video/data
rm -f /usr/lib/unifi-video/logs
ln -s /srv/unifi-video/logs /usr/lib/unifi-video/logs
ln -s /srv/unifi-video /usr/lib/unifi-video/data

/usr/sbin/unifi-video --nodetach --verbose start
