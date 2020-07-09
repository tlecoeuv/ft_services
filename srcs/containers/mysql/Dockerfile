FROM alpine

MAINTAINER tlecoeuv@student.42.fr

RUN apk update
RUN apk add mysql mysql-client
RUN rm -rf /var/cache/apk/*

RUN mkdir -p /run/mysqld
RUN cp -rp /var/run/mysqld /var/run/mysqld.bak

COPY srcs/start.sh /tmp/start.sh
COPY srcs/my.cnf /etc/mysql/my.cnf

EXPOSE 3306

ENTRYPOINT sh /tmp/start.sh
