FROM alpine

MAINTAINER tlecoeuv@student.42.fr

RUN apk update
RUN apk add lighttpd \
php7 php7-mbstring php7-cgi php7-openssl php7-session php7-zlib php7-common php7-iconv php7-json php7-gd php7-curl php7-xml php7-mysqli php7-imap php7-cgi fcgi php7-pdo php7-pdo_mysql php7-soap php7-xmlrpc php7-posix php7-mcrypt php7-gettext php7-ldap php7-ctype php7-dom --no-cache

# COPY srcs/config.inc.php /var/www/localhost/htdocs/config.inc.php
ADD  http://files.directadmin.com/services/all/phpMyAdmin/phpMyAdmin-5.0.1-all-languages.tar.gz /tmp/

RUN tar -xf /tmp/phpMyAdmin-5.0.1-all-languages.tar.gz --strip-components=1 -C /var/www/localhost/htdocs
RUN rm -f /tmp/phpMyAdmin-5.0.1-all-languages.tar.gz

RUN mkdir -p /var/www/localhost/htdocs/tmp
RUN chmod 777 /var/www/localhost/htdocs/tmp

RUN mkdir -p /var/run/lighttpd
RUN touch /var/run/lighttpd/php-fastcgi.socket
RUN chown -R lighttpd:lighttpd /var/run/lighttpd

RUN sed -i 's/\/run\/lighttpd.pid/\/run\/lighttpd\/php-fast-cgi.socket/g' /etc/lighttpd/lighttpd.conf
RUN sed -i 's/#   include "mod_fastcgi.conf"/include "mod_fastcgi.conf"/g' /etc/lighttpd/lighttpd.conf
RUN sed -i 's/\/usr\/bin\/php-cgi/\/usr\/bin\/php-cgi7/g' /etc/lighttpd/mod_fastcgi.conf

EXPOSE 80

ENTRYPOINT lighttpd -D -f /etc/lighttpd/lighttpd.conf
