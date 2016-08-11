# Dockerfile for Squid3, with SSL enabled.
# http://www.squid-cache.org/

FROM ubuntu:16.04
RUN apt-get update
RUN apt-get -y upgrade

# Install dependencies
RUN apt-get -y install apache2 logrotate squid-langpack ca-certificates squid
RUN apt-get -y install libgssapi-krb5-2 libltdl7 libecap3 libnetfilter-conntrack3 nano wget

# Install from locally generated .deb files
ADD deb /root/
RUN dpkg -i /root/*.deb
RUN rm /root/*.deb

# Install configuration files
ADD config/squid3-ssl.conf /etc/squid3/squid3-ssl.conf
ADD config/openssl.cnf /etc/squid3/openssl.cnf

# Add certs directory
ADD certs /etc/squid3/certs

# Initialize dynamic certs directory
RUN /usr/lib/squid3/ssl_crtd -c -s /var/lib/ssl_db
RUN chown -R proxy:proxy /var/lib/ssl_db

# Create cache directory
RUN mkdir /srv/squid3
RUN chown proxy:proxy /srv/squid3
RUN touch /srv/squid3/init_volume
VOLUME /srv/squid3

# Install run.sh and make-certs.sh
ADD bin /usr/local/bin/
RUN chmod 755 /usr/local/bin/run.sh /usr/local/bin/make-certs.sh

RUN apt-get -y install squidguard
RUN wget http://dsi.ut-capitole.fr/blacklists/download/blacklists.tar.gz
RUN tar -xzf blacklists.tar.gz
RUN cp -R blacklists/* /var/lib/squidguard/db/
ADD squidGuard.conf /etc/squidguard/
RUN ln -s /etc/squidguard/squidGuard.conf /etc/squid3/
RUN chown -R proxy:proxy  /var/log/squid /var/lib/squidguard
RUN squidGuard -C all

RUN wget http://dsi.ut-capitole.fr/blacklists/download/blacklists.tar.gz

# Install sarg
RUN apt-get -y install sarg
ADD sarg.conf /etc/sarg/
RUN ln -s /var/lib/sarg/ /var/www/html
RUN (crontab -l 2>/dev/null; echo "00 01 * * * /usr/sbin/sarg-reports daily") | crontab -

EXPOSE 3128
CMD ["/bin/bash","/usr/local/bin/run.sh"]
