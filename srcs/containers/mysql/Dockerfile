FROM alpine

MAINTAINER tlecoeuv@student.42.fr

RUN apk update
RUN apk add mysql mysql-client --no-cache

RUN mkdir -p /run/mysqld
RUN cp -rp /var/run/mysqld /var/run/mysqld.bak

COPY srcs/init_db.sh /tmp/init_db.sh
COPY srcs/my.cnf /etc/mysql/my.cnf

VOLUME ["/var/lib/mysql"]

EXPOSE 3306

ENTRYPOINT sh /tmp/init_db.sh
