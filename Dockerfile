FROM docker.io/library/fedora:34

RUN dnf -y upgrade && dnf -y install httpd php php-common php-mysqlnd php-xml php-json php-gd php-mbstring php-intl php-pecl-zip php-pecl-imagick php-process redis php-pecl-redis && dnf -y clean all

#  Debugging tools
#RUN dnf -y install wget procps-ng

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
COPY virtualhosts.conf /etc/httpd/conf.d/virtualhosts.conf
COPY redis.conf /etc/redis/redis.conf

VOLUME /var/www/html
VOLUME /var/lib/mysql/mysql.sock

EXPOSE 80/tcp

ENTRYPOINT /usr/local/bin/entrypoint.sh

LABEL org.opencontainers.image.authors="dave@daveking.com"
