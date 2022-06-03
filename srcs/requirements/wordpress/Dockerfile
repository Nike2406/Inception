# задает базовый образ
FROM debian:buster

# выполняет комманды внутри базового образа
RUN apt-get update
RUN apt-get -y install php7.3 php-mysqli php-fpm mariadb-client

# открываем порт по сабжекту
EXPOSE 9000

COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d
COPY ./tools /var/www/

CMD bash /var/www/wp_script.sh