# задает базовый образ
FROM debian:baster

# выполняет комманды внутри базового образа
RUN apt-get update
RUN apt-get install -y nginx openssl

# открываем порт
EXPOSE 443

# копирует в контейнер файлы и папки
# копируем конфиг из нашей папки в папку по офф доке
COPY ./conf/nginx.conf /etc/nginx/

