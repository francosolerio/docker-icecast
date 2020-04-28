#!/bin/sh

env

set -x

set_val() {
    if [ -n "$2" ]; then
        echo "set '$2' to '$1'"
        sed -i "s/<$2>[^<]*<\/$2>/<$2>$1<\/$2>/g" /etc/icecast-owned.xml
    else
        echo "WARNING: setting for '$1' is missing!" >&2
	fi
}

cp /etc/icecast.xml /etc/icecast-owned.xml

set_val $ICECAST_SOURCE_PASSWORD 	source-password
set_val $ICECAST_RELAY_PASSWORD 	relay-password
set_val $ICECAST_ADMIN_PASSWORD 	admin-password
set_val $ICECAST_PASSWORD 			password
set_val $ICECAST_LOCATION 			location
set_val $ICECAST_HOSTNAME 			hostname
set_val $ICECAST_ADMIN 				admin
set_val $ICECAST_MAX_SOURCES 		sources
set_val $ICECAST_MAX_LISTENERS 		clients

sed -i'' "s/<ssl-private-key>[^<]*<\/ssl-private-key>/<ssl-private-key>\/etc\/key-owned.pem<\/ssl-private-key>/g" /etc/icecast-owned.xml

cat /etc/icecast-owned.xml

cp /etc/key.pem /etc/key-owned.pem
chown -R icecast /etc/key-owned.pem

chown -R icecast /var/log/icecast

supervisord -n -c /etc/supervisord.conf
