# Apache 2.4/PHP 7.4 Docker Container for Owncloud

## The Problem

I upgraded my web server from Fedora 33 to Fedora 35.  This means it now runs PHP 8, not PHP 7 like before.  Owncloud only runs under PHP 7.  My Owncloud instance is broken.

## The Solution

I created a Docker container using Fedora 34 as the base, containing the Apache HTTP server and PHP 7.4.  It binds to my existing Owncloud installation, config and data at /var/www/html and to the mysql socket of my existing mariadb server: /var/lib/mysql/mysql.sock.  My Owncloud config specifies the use of redis for Owncloud caching so that is installed inside the container.

I set up proxy routing to the container's HTTP port from the /owncloud URL in my main HTTP server's configuration.

    RewriteRule ^/owncloud/?$ http://127.0.0.1:8888/owncloud/index.php [proxy]
    RewriteRule ^/owncloud/(.*) http://127.0.0.1:8888/owncloud/$1 [proxy]

I set up a systemd service to start the container running on boot.

This is meant to be a temporary fix, until the time when Owncloud supports PHP 8 and I can return to my previous configuration.  Switching back only requires that I remove the proxy routing in my main HTTP server's config.
