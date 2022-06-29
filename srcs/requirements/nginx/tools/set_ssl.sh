#!/bin/bash/

# Для того, чтобы не создавался каждый раз новый ключ
# сделаем немного оптимизации с помощью if-fi

if [ ! -f /etc/ssl/certs/nginx.crt ]; then
echo "NGINX: Set ssl start";
openssl req -x509 -nodes -days 3650 -newkey rsa:2048 -keyout /etc/ssl/private/nginx.key -out /etc/ssl/certs/nginx.crt -subj "/C=RU/ST=Tatarstan/L=Kazan/O=School21/CN=prochell.42.fr" 
echo "NGINX: Set ssl done!";
fi
nginx -g 'daemon off;';
