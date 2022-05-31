#!/bin/bash/

# Для того, чтобы не создавался каждый раз новый ключ
# сделаем немного оптимизации с помощью if-fi

if [! -f /etc/ssl/certs/nginx.crt]; then
echo "\e[0;33mNGINX: Set ssl start \e[0m";
# генерируем самоподписаный сертификат SSL
openssl req \ # req - создает и обрабатывает запросф сертов
	 -x509 \ # выводит самоподписанный серт вместо запроса
	 -nodes \ # если будет создан закрытый ключ, то он не будет зашифрован
	 -days 3650 \ # срок годности серта
	 -newkey rsa:2048 \ # создает новый запрос сертификата и новый закрытый ключ
	 \ # где rsa:2048 - размер ключа в битах
	 -keyout /etc/nginx/ssl/nginx.key \ # новый ключ
	 -out /etc/nginx/ssl/nginx.crt \ # новый серт
	 -subj "/C=RU/ST=Tatarstan/L=Kazan/O=School21/CN=prochell.42.fr" \
	 # для сертов необходимо заполнить доп инф. деллается через -subj
echo "NGINX: Set ssl done!";
fi
