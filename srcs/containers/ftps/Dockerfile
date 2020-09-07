FROM alpine

RUN	apk add --no-cache vsftpd ; \
	apk add openssl ; \
	apk add openrc 

RUN	openssl req -x509 -nodes -days 7300 -newkey rsa:2048 -subj "/C=FR/ST=fr/L=Paris/O=School42/CN=$MINIKUBE_IP" -keyout /etc/ssl/certs/vsftpd.pem -out /etc/ssl/certs/vsftpd.pem

RUN	chmod 755 /etc/ssl/certs/vsftpd.pem

COPY srcs/start.sh /bin/start.sh
COPY srcs/vsftpd.conf /etc/vsftpd/vsftpd.conf

EXPOSE 21
EXPOSE 21000-21010
VOLUME /ftp/ftp

RUN chmod 775 /bin/start.sh

CMD "/bin/start.sh"
