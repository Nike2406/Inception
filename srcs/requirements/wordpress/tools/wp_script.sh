#!/bin/bash

# Замените все вхождения строки в файле, перезаписав файл (т.е. на месте):
sed -i "s/listen = \/run\/php\/php7.3-fpm.sock/listen = 9000/" "/etc/php/7.3/fpm/pool.d/www.conf";
# -R рекурсивное изменение прав доступа для каталогов и их содержимого
chmod -R 775 /var/www/html/wordpress/;
# Следующий пример изменит владельца всех файлов и 
# подкаталогов в /var/www/html/wordpress каталоге на нового владельца и группу с именем www-data :
chown -R www-data /var/www/html/wordpress/;
mkdir -p /run/php/;
touch /run/php/php7.3-fpm.pid;

# php -S 0.0.0.0:9000 -t /var/www/html/wordpress


# Немного оптимизации
echo "Wordpress: Start to create users..."
if [ ! -f /var/www/html/wordpress/wp-config.php ]; then
mkdir -p /var/www/html/wordpress/
wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar;
chmod +x wp-cli.phar; 
mv wp-cli.phar /usr/local/bin/wp;
cd /var/www/html/wordpress/;

# Создаем папку с сайтом
# mkdir -p /var/www/html/wordpress/mysite;
# cp /var/www/html/wordpress/index.html /var/www/html/wordpress/mysite/index.html;

wp core download --allow-root;
mv /var/www/wp-config.php /var/www/html/wordpress/

echo "Wordpress: Users created!"
# Зоздаем рут-пользователя
wp core install --allow-root --url=${DOMAIN_NAME} --title=${WORDPRESS_NAME} --admin_user=${WORDPRESS_ROOT_LOGIN} --admin_password=${MYSQL_ROOT_PASSWORD} --admin_email=${WORDPRESS_ROOT_EMAIL};
# Зоздаем второго пользователя
wp user create ${MYSQL_USER} ${WORDPRESS_USER_EMAIL} --user_pass=${MYSQL_PASSWORD} --role=author --allow-root;

# enable redis cache
sed -i "40i define( 'WP_REDIS_HOST', '$REDIS_HOST' );"      wp-config.php
sed -i "41i define( 'WP_REDIS_PORT', 6379 );"               wp-config.php
sed -i "42i define( 'WP_REDIS_TIMEOUT', 1 );"               wp-config.php
sed -i "43i define( 'WP_REDIS_READ_TIMEOUT', 1 );"          wp-config.php
sed -i "44i define( 'WP_REDIS_DATABASE', 0 );\n"            wp-config.php

wp plugin install redis-cache --activate --allow-root
wp plugin update --all --allow-root

else
echo "Wordpress: Users already exists!"
fi

wp redis enable --allow-root

echo "Wordpress started on :9000"
/usr/sbin/php-fpm7.3 -F