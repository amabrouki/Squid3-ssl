# Dockerfile.build
# Build debian packages for Squid3, with SSL enabled.
# http://www.squid-cache.org/

FROM ubuntu

RUN apt-get update
RUN apt-get -y upgrade

# Install build dependencies
RUN apt-get -y install libssl-dev apt-utils
RUN apt-get -y build-dep squid3

# Download source
RUN mkdir /src
RUN cd /src && apt-get source squid3

# Edit debian/rules to build with SSL
RUN sed -i 's/--enable-ecap/--enable-ecap --with-openssl --enable-ssl --enable-ssl-crtd/' /src/squid3-3.5.12/debian/rules

# Build debs
RUN apt-get -y install devscripts
RUN cd /src/squid3-3.5.12 && debuild -us -uc -b
