# Inception

## Mandatory

1. #### Создание виртуальной машины

Образ [Ubuntu stable](https://releases.ubuntu.com/20.04/) и его [настройка](https://losst.ru/kak-polzovatsya-virtualbox#2_%D0%A1%D0%BE%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5_%D0%B2%D0%B8%D1%80%D1%82%D1%83%D0%B0%D0%BB%D1%8C%D0%BD%D0%BE%D0%B9_%D0%BC%D0%B0%D1%88%D0%B8%D0%BD%D1%8B) через VirtualBox.
Рекомендую настраивать разрешение через саму систему, а не через scale VB.

2. #### Устновка необходимых программ

Например, vim и make

	$ sudo apt-get install vim
	$ sudo apt-get install make

3. #### (Опционально) Подключаем SSH

В первую очередь проверить, установлени и запущени ли ssh на виртуальной машине:
`sudo systemctl status ssh`, если нет устанавливаем

	$ sudo apt-get update
	$ sudo apt install openssh-server

В файле `/etc/ssh/sshd_config` ищем строку `#Port 22`, раскомментируем и меняем,
например, на `Port 4242`

Узнаем ip виртуальной машины и порт (обычно 10.0.2.15 и порт 22) командой `ip addr`
![img3](./git_srcs/3.png)

Заходим в настройки виртуальной машины
Сеть -> Проброс портов и создаем новое соединение как на картинке
![img1](./git_srcs/1.png) ![img2](./git_srcs/2.png)

Перезапускаем сервис: `$ sudo service ssh restart`

Подключаемся через терминал с локальной машины: `$ ssh your_username@localhost -p 4242`

Для подключения **Visual Studio Code** к виртуальной машине запустите виртуальную машину. Откройте Visual Studio Code на основной ОС. Слева на панели VS Code выберите Extensions (Расширения) и найдите и скачайте расширение "Remote - SSH". Затем в VS Code откройте меню с помощью сочетания клавиш Command+Shift+P, введите "Remote-SSH: Connect to Host..." и нажмите Enter. Там же введите <your_login>@localhost:<your_port>, затем введите пароль пользователя виртуальной машины, откройте необходимую папку через Explorer->Open Folder слева на панели VS Code, снова введите пароль пользователя виртуальной машины и создайте новый терминал

[Подробнее](https://comp-security.net/%D0%BF%D0%BE%D0%B4%D0%BA%D0%BB%D1%8E%D1%87%D0%B8%D1%82%D1%8C%D1%81%D1%8F-%D0%BA-%D0%B2%D0%B8%D1%80%D1%82%D1%83%D0%B0%D0%BB%D1%8C%D0%BD%D0%BE%D0%B9-%D0%BC%D0%B0%D1%88%D0%B8%D0%BD%D0%B5-%D0%BF%D0%BE-ssh/)

4. #### Изменяем хосты

Открываем с правами админа /etc/hosts и меняем localhost на 'username'.42.fr

	example: sudo vim /etc/hosts

5. #### Установка [Docker](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-20-04-ru)

Достаточно первого шага.

6. #### Установка [Docker Compose](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-compose-on-ubuntu-20-04-ru)

7. #### Создаем Makefile

Для удобства [делаем](./Makefile) запуск, остановку и очистку всего.

8. #### [docker-compose.yml](./srcs/docker-compose.yml)

В директории __srcs__ создаем docker-compose.yml

Хороший [разбор](https://youtu.be/xuO8zv62HXM?list=PL0lO_mIqDDFX1c0JHogP5YuZdOVawoepS)

Создаем необходимые директории

	mkdir -p /home/${USER}/Desktop/data/db
	mkdir -p /home/${USER}/Desktop/data/wp

9. #### Настраиваем блок с [nginx](./srcs/requirements/nginx/)

Офицальныая [дока](https://hub.docker.com/_/nginx) с докерхаба
Более [подробно](https://serveradmin.ru/ustanovka-i-nastrojka-nginx/)

Настраиваем [скрипт](./srcs/requirements/nginx/tools/set_ssl.sh) для ssl-шифрования по [этой](https://webguard.pro/web-services/nginx/generacziya-ssl-sertifikata-dlya-nginx-openssl.html) инструкции

Для перенаправления данных исползуем настройки [FastCGI](https://www.nginx.com/resources/wiki/start/topics/examples/phpfcgi/) для PHP FPM

Не забываем добавлять .dockerignore для игнорирования файлов во время сборки

9. #### [MariaDB](./srcs/requirements/mariadb/)

- Создаем конфигурационный [файл](https://exampleconfig.com/view/mariadb-ubuntu18-04-etc-mysql-mariadb-conf-d-50-server-cnf)
- Создаем базу данных на основе wordpress
- host_name должен быть либо %, либо Вы должны задать его принудительно и использовать его имя.

10. #### [Wordpress](./srcs/requirements/wordpress/)

- Создаем конфигурационный файл пула [www.conf](https://www.php.net/manual/ru/install.fpm.configuration.php) ([__Пример__](https://gist.github.com/rvanzee/2352093)), который позволяет запускать несколько дочерних процесов в разными конфигурациями
- Создаем конфигруационный файл wordPress ([wp-config.php](https://www.wpbeginner.com/beginners-guide/how-to-edit-wp-config-php-file-in-wordpress/)). Не забываем сгенерировать свои ключи [отсюда](https://api.wordpress.org/secret-key/1.1/salt/).
- По сабжекту нужно создать двух пользователей, один из которых админ, при этом, имя админа не должно быть andmin, andmin-123 etc (WTF!?).

## Bonus

1. #### Устанавливаем Redis

1.1 Добавляем сервис в docker-compose
1.2 Пишем скрипт в папку [tools](./srcs/requirements/bonus/redis/tools/set_redis.sh)
1.3 Настраиваем [Dockerfile](./srcs/requirements/bonus/redis/Dockerfile)

- Офф [дока](https://hub.docker.com/_/redis)

2. #### FTP-server
3. #### Your site
4. #### [Adminer](https://dev.to/codewithml/setup-adminer-with-docker-for-database-management-4dd2)
5. #### [Portainer](https://nextgentips.com/2022/01/26/how-to-install-portainer-ce-with-docker-compose/)


---

### Полезные ссылки

- [Checklist](./checklist.pdf)
- [Правильный запуск процессов в контейнере с PID 1](https://it-lux.ru/docker-entrypoint-pid-1/)
- [Docker docks](https://docs.docker.com/)
- Полезная [статья](https://habr.com/ru/company/ruvds/blog/450312/) по docker compose на хабре
- [Роли пользователей WordPress](https://hostenko.com/wpcafe/tutorials/roli-polzovateley-wordpress-razbiraemsya-kto-est-kto/#:~:text=%D0%92%20WordPress%20%D0%B5%D1%81%D1%82%D1%8C%20%D1%80%D0%B0%D0%B7%D0%BD%D1%8B%D0%B5%20%D1%82%D0%B8%D0%BF%D1%8B,%D1%82%D0%BE%D0%B3%D0%BE%2C%20%D1%87%D1%82%D0%BE%20%D0%BF%D0%BE%D0%BB%D1%8C%D0%B7%D0%BE%D0%B2%D0%B0%D1%82%D0%B5%D0%BB%D1%8E%20%D1%80%D0%B0%D0%B7%D1%80%D0%B5%D1%88%D0%B5%D0%BD%D0%BE%20%D0%B4%D0%B5%D0%BB%D0%B0%D1%82%D1%8C.)
- freeCodeCamp [Docker](https://www.freecodecamp.org/news/docker-simplified-96639a35ff36/)
- Гоша Дударь [плейлист по докеру](https://www.youtube.com/playlist?list=PL0lO_mIqDDFX1c0JHogP5YuZdOVawoepS)
- Разные настройки, включая SSH на примере проекта [Born2BeRoot](https://baigal.medium.com/born2beroot-e6e26dfb50ac)
- [Статья](https://habr.com/ru/company/otus/blog/337688/) по продвинутой настройке docker-compose
- Зайти внутр контейнера: docker exec -it <container_name> bash
