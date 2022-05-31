-- создаем базу
CREATE DATABASE wordpress;
CREATE USER 'prochell'@'%' IDENTIFIED BY '12345';
-- предоставляем созданному пользователю права для управление базой
GRANT ALL PRIVILEGES ON wordpress.* TO 'prochell'@'%';
-- сохраняем изменения
FLUSH PRIVILEGES;

-- создаем универсального суперпользователя
ALTER USER 'root'@'localhost' IDENTIFIED BY '12345'