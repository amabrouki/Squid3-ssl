# Squid3-ssl

A Squid3 proxy (with SSL enabled) in a Docker container.

# Details

<ul>

<li>Squid (Version 3).</li>
<li>Ubuntu 16.04.</li><li>Built from source, with --enable-ecap --with-openssl --enable-ssl --enable-ssl-crtd.</li>
</ul>

# Building the Squid3 Proxy Docker Image

Clone the git repo and cd into the root directory.

<pre><code>$ git clone https://github.com/amabrouki/Squid3-ssl.git
$ cd Squid3-ssl

# Build with Dockerfile in Dfile
$ docker build -t squid Dfile
# 
$ docker run -v deb:/src/debs squid /bin/sh -c 'cp /src/*.deb /src/debs/'
# 
$ docker build -t squid3 /etc/repo
</code></pre>

# Running the Squid3 Proxy

