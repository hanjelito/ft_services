FROM	alpine:3.12.1

RUN		apk add wget nginx php7 php7-fpm php7-mysqli php7-mbstring php7-json php7-session && \
		apk add telegraf --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ --allow-untrusted --no-cache && \
		wget https://files.phpmyadmin.net/phpMyAdmin/4.9.2/phpMyAdmin-4.9.2-all-languages.tar.gz && \
		tar -xzvf phpMyAdmin-4.9.2-all-languages.tar.gz && \
		rm -rf phpMyAdmin-4.9.2-all-languages.tar.gz && \
		mkdir -p /www /etc/telegraf && mv phpMyAdmin-4.9.2-all-languages /www/phpmyadmin

RUN     adduser -D -g 'www' www && \
		mkdir -p /run/nginx www

RUN		chown -R www:www /var/lib/nginx && \
		chown -R www:www /www

COPY	/srcs/telegraf.conf			/etc/telegraf/
COPY 	/srcs/nginx.conf			/etc/nginx/nginx.conf
COPY	/srcs/config.inc.php		/www/phpmyadmin/
COPY	/srcs/start.sh				/


RUN		chmod +x start.sh

EXPOSE	5000

CMD ./start.sh
