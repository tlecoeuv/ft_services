FROM alpine

MAINTAINER tlecoeuv@student.42.fr

RUN apk update
RUN apk add mariadb mariadb-client
RUN rm -rf /var/cache/apk/*


COPY srcs/start.sh /tmp/start.sh
COPY srcs/init_db.sh /tmp/init_db.sh
COPY srcs/my.cnf /etc/mysql/my.cnf
RUN chmod 777 tmp/start.sh
RUN chmod 777 tmp/init_db.sh

EXPOSE 3306

ENTRYPOINT sh /tmp/start.sh
