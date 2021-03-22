#!/bin/sh

# telegraf & php -S 0.0.0.0:5000 -t /www/phpmyadmin/ && nginx -g 'daemon off;'
# telegraf & php -S 0.0.0.0:5000 -t /www/phpmyadmin/ && nginx
# nginx -g 'daemon off;'
php-fpm7  &
/usr/sbin/nginx -g "daemon off;"