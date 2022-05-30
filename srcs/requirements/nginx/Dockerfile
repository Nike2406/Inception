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
COPY ./tools/set_ssl.sh /var/www/

CMD bash /var/www/set_ssl.sh

# Пуск nginx
# Nginx использует daemon off директиву для запуска на переднем плане
ENTRYPOINT ["nginx", "-g", "daemon off;"]