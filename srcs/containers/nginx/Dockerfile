FROM alpine:latest

RUN apk update
RUN apk add nginx
RUN mkdir -p /run/nginx

EXPOSE 80
EXPOSE 433

ENTRYPOINT ["nginx", "-g", "daemon off;"]
