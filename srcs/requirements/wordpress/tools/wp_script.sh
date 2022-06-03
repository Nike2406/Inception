#!/bin/bash

# Немного оптимизации
echo "Wordpress: Start to create users..."
if [ ! -f /var/www/html/wordpress/wp-config.php ]; then
# Зоздаем рут-пользователя
wp core install --allow-root --url=${DOMAIN_NAME} --title=${WORDPRESS_NAME} --admin_user=${WORDPRESS_ROOT_LOGIN} --admin_password=${MYSQL_ROOT_PASSWORD} --admin_email=${WORDPRESS_ROOT_EMAIL};
# Зоздаем второго пользователя
wp user create ${MYSQL_USER} ${WORDPRESS_USER_EMAIL} --user_pass=${MYSQL_PASSWORD} --role=author --allow-root;
echo "Wordpress: Users created!"
else
echo "Wordpress: Users already exists!"
fi