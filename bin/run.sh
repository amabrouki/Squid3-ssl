#!/bin/sh
# Install cert
cp -v /etc/squid3/certs/*.crt /usr/share/ca-certificates/
find /etc/squid3/certs -name '*.crt'  -printf "%f\n" >> /etc/ca-certificates.conf
/usr/sbin/update-ca-certificates --fresh

chown proxy:proxy /etc/squid3/squidGuard.conf
chown -R proxy:proxy /var/lib/squidguard/db
chown -R proxy:proxy /var/log/squid/

chmod 666 /etc/squid3/squidGuard.conf
chmod -R 666 /var/lib/squidguard/db
chmod -R 666 /var/log/squid/
find /var/lib/squidguard/db -type d -exec chmod 755 \{\} \; -print
chmod 755 /var/log/squid

service apache2 start
# Prep cache directory
/usr/sbin/squid3 -z -N -f /etc/squid3/squid3-ssl.conf
# Run squid
/usr/sbin/squid3 -N -f /etc/squid3/squid3-ssl.conf
