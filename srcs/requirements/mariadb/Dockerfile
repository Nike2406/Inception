# задает базовый образ
FROM debian:buster

# выполняет комманды внутри базового образа
RUN apt-get update
RUN apt-get install -y mariadb-server

# копирует в контейнер файлы и папки
# копируем конфиг из нашей папки в папку по офф доке
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/
COPY ./tools /var/www/

# открываем порт по сабжекту
EXPOSE 3306

# запускаем сервис внутри контейнера и создаем базу
# после сразу удаляем, чтобы каждый раз база не пересоздавалась (?)
RUN service mysql start && mysql < /var/www/createdb.sql && rm -f /var/www/createdb.sql

CMD /usr/bin/mysqld_safe
