FROM	alpine:3.12.1

RUN		apk update && apk add vsftpd openssl && \
		apk add telegraf --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ --allow-untrusted --no-cache && \
		openssl req -x509 -nodes -days 365 \
		-newkey rsa:2048 -subj '/CN=127.0.0.1' \
		-keyout /etc/ssl/private/vsftpd.key \
		-out /etc/ssl/certs/vsftpd.crt

RUN 	adduser --home=/var/www -D juan_gon && \ 
		echo "juan_gon:123456" | chpasswd

COPY	/srcs/telegraf.conf			/etc/telegraf/
COPY	/srcs/vsftpd.conf			/etc/vsftpd
COPY	/srcs/start.sh				./

RUN chmod +x start.sh

EXPOSE	20 21 21009-21011

CMD ./start.sh