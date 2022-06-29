#!/bin/bash

# Замените все вхождения строки в файле, перезаписав файл (т.е. на месте):
sed -i "s/listen = \/run\/php\/php7.3-fpm.sock/listen = 9000/" "/etc/php/7.3/fpm/pool.d/www.conf";
# -R рекурсивное изменение прав доступа для каталогов и их содержимого
chmod -R 775 /var/www/html;
# Следующий пример изменит владельца всех файлов и 
# подкаталогов в /var/www/html/wordpress каталоге на нового владельца и группу с именем www-data :
chown -R www-data /var/www/html;
mkdir -p /run/php/;
touch /run/php/php7.3-fpm.pid;

# php -S 0.0.0.0:9000 -t /var/www/html/wordpress


# Немного оптимизации
echo "Wordpress: Start to create users..."
if [ ! -f /var/www/html/wordpress/wp-config.php ]; then
mkdir -p /var/www/html
wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar;
chmod +x wp-cli.phar; 
mv wp-cli.phar /usr/local/bin/wp;
cd /var/www/html;
wp core download --allow-root;
mv /var/www/wp-config.php /var/www/html/
# Зоздаем рут-пользователя
wp core install --allow-root --url=${DOMAIN_NAME} --title=${WORDPRESS_NAME} --admin_user=${WORDPRESS_ROOT_LOGIN} --admin_password=${MYSQL_ROOT_PASSWORD} --admin_email=${WORDPRESS_ROOT_EMAIL};
# Зоздаем второго пользователя
wp user create ${MYSQL_USER} ${WORDPRESS_USER_EMAIL} --user_pass=${MYSQL_PASSWORD} --role=author --allow-root;
echo "Wordpress: Users created!"
else
echo "Wordpress: Users already exists!"
fi

echo "Wordpress started on :9000"
/usr/sbin/php-fpm7.3 -F