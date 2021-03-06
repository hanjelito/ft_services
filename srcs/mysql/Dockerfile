FROM	alpine:3.12.1


RUN		apk upgrade --update && \
		apk add --no-cache mysql mysql-client
		
COPY	/srcs/telegraf.conf		./
COPY	/srcs/my.cnf			./
COPY	/srcs/wordpress.sql		./
COPY	/srcs/start.sh			./

RUN chmod +x start.sh
		
RUN 	mkdir -p /run/mysqld && \
		mv my.cnf /etc/

RUN apk add --no-cache --repository http://dl-3.alpinelinux.org/alpine/edge/community telegraf && \
	mkdir -p /etc/telegraf && \
	mv telegraf.conf /etc/telegraf/

EXPOSE 3306

CMD ./start.sh
