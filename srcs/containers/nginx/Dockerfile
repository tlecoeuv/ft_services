FROM alpine:latest

RUN apk update
RUN apk add nginx
RUN mkdir -p /run/nginx
COPY ./srcs/* /srcs/

RUN apk add openssl
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt < srcs/certificate

RUN apk add openssh
RUN usr/bin/ssh-keygen -A
COPY	sshd_config /etc/ssh/

COPY ./srcs/nginx.conf /etc/nginx/nginx.conf

COPY setup.sh .
RUN chmod +x setup.sh

EXPOSE 80
EXPOSE 433
EXPOSE 22

ENTRYPOINT ./setup.sh
