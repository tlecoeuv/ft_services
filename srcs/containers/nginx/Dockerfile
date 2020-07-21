FROM alpine:latest

RUN apk update
RUN apk add nginx
RUN mkdir -p /run/nginx
COPY ./srcs/* /srcs/

RUN apk add openssl
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt < srcs/certificate

COPY ./srcs/nginx.conf /etc/nginx/nginx.conf

EXPOSE 80
EXPOSE 433

ENTRYPOINT ["nginx", "-g", "daemon off;"]
