# Inception

1. #### Создание виртуальной машины

Образ [Ubuntu stable](https://releases.ubuntu.com/20.04/) и его [настройка](https://losst.ru/kak-polzovatsya-virtualbox#2_%D0%A1%D0%BE%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5_%D0%B2%D0%B8%D1%80%D1%82%D1%83%D0%B0%D0%BB%D1%8C%D0%BD%D0%BE%D0%B9_%D0%BC%D0%B0%D1%88%D0%B8%D0%BD%D1%8B) через VirtualBox.
Рекомендую настраивать разрешение через саму систему, а не через scale VB.

2. #### Установка [Docker](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-compose-on-ubuntu-20-04-ru)

Достаточно первого шага.

3. #### Установка [Docker Compose](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-compose-on-ubuntu-20-04-ru)

4. #### Уствновка необходимых программ (не забываем о make)

5. #### Изменяем хосты

Открываем с правами админа /etc/hosts и меняем localhost на 'username'.42.fr

	example: `sudo vim /etc/hosts`

---

### Полезные ссылки

- [Правильный запуск процессов в контейнере с PID 1](https://it-lux.ru/docker-entrypoint-pid-1/)
- [Docker docks](https://docs.docker.com/)
- [Роли пользователей WordPress](https://hostenko.com/wpcafe/tutorials/roli-polzovateley-wordpress-razbiraemsya-kto-est-kto/#:~:text=%D0%92%20WordPress%20%D0%B5%D1%81%D1%82%D1%8C%20%D1%80%D0%B0%D0%B7%D0%BD%D1%8B%D0%B5%20%D1%82%D0%B8%D0%BF%D1%8B,%D1%82%D0%BE%D0%B3%D0%BE%2C%20%D1%87%D1%82%D0%BE%20%D0%BF%D0%BE%D0%BB%D1%8C%D0%B7%D0%BE%D0%B2%D0%B0%D1%82%D0%B5%D0%BB%D1%8E%20%D1%80%D0%B0%D0%B7%D1%80%D0%B5%D1%88%D0%B5%D0%BD%D0%BE%20%D0%B4%D0%B5%D0%BB%D0%B0%D1%82%D1%8C.)
- freeCodeCamp [Docker](https://www.freecodecamp.org/news/docker-simplified-96639a35ff36/)
- Гоша Дударь [плейлист по докеру](https://www.youtube.com/playlist?list=PL0lO_mIqDDFX1c0JHogP5YuZdOVawoepS)
