#!/bin/sh

env

set -x

cp /etc/icecast.xml ~/icecast.xml

if [ -n "$ICECAST_SOURCE_PASSWORD" ]; then
    sed -i'' "s/<source-password>[^<]*<\/source-password>/<source-password>$ICECAST_SOURCE_PASSWORD<\/source-password>/g" ~/icecast.xml
fi

if [ -n "$ICECAST_RELAY_PASSWORD" ]; then
    sed -i'' "s/<relay-password>[^<]*<\/relay-password>/<relay-password>$ICECAST_RELAY_PASSWORD<\/relay-password>/g" ~/icecast.xml
fi

if [ -n "$ICECAST_ADMIN_PASSWORD" ]; then
    sed -i'' "s/<admin-password>[^<]*<\/admin-password>/<admin-password>$ICECAST_ADMIN_PASSWORD<\/admin-password>/g" ~/icecast.xml
fi

if [ -n "$ICECAST_PASSWORD" ]; then
    sed -i'' "s/<password>[^<]*<\/password>/<password>$ICECAST_PASSWORD<\/password>/g" ~/icecast.xml
fi

if [ -n "$ICECAST_LOCATION" ]; then
    sed -i'' "s/<location>[^<]*<\/location>/<location>$ICECAST_LOCATION<\/location>/g" ~/icecast.xml
fi

if [ -n "$ICECAST_HOSTNAME" ]; then
    sed -i'' "s/<hostname>[^<]*<\/hostname>/<hostname>$ICECAST_HOSTNAME<\/hostname>/g" ~/icecast.xml
fi

if [ -n "$ICECAST_ADMIN" ]; then
    sed -i'' "s/<admin>[^<]*<\/admin>/<admin>$ICECAST_ADMIN<\/admin>/g" ~/icecast.xml
fi

if [ -n "$ICECAST_MAX_SOURCES" ]; then
    sed -i'' "s/<sources>[^<]*<\/sources>/<sources>$ICECAST_MAX_SOURCES<\/sources>/g" ~/icecast.xml
fi

if [ -n "$ICECAST_MAX_LISTENERS" ]; then
    sed -i'' "s/<clients>[^<]*<\/clients>/<clients>$ICECAST_MAX_LISTENERS<\/clients>/g" ~/icecast.xml
fi

cp -f ~/icecast.xml /etc/icecast.xml
rm ~/icecast.xml

cat /etc/icecast.xml

chown -R icecast /var/log/icecast
supervisord -n -c /etc/supervisord.conf
