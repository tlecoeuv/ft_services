FROM alpine:latest

RUN apk update
RUN apk add influxdb

EXPOSE 8086

CMD 	influxd run -config /etc/influxdb.conf
