# Squid3-ssl

A Squid3 proxy (with SSL enabled) in a Docker container.

# Details

<ul>

<li>Squid (Version 3.3.8).</li>
<li>Ubuntu 13.10 (Saucy Salamander).</li><li>Built from source, with --enable-ssl.</li>
<li>Automatically generates self-signed certificate.</li>
<li>Configured to cache Docker images (default config for Squid3 doesn't handle Docker images very well.)</li>
</ul>

# Building the Squid3 Proxy Docker Image

Clone the git repo and cd into the root directory.

<pre><code>$ git clone https://github.com/amabrouki/Squid3-ssl.git
$ cd Squid3-ssl
</code></pre>
