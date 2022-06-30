FROM debian:buster

RUN apt-get update && apt-get install redis-server -y

COPY ./tools/set_redis.sh /var/www/set_redis.sh

CMD bash /var/www/set_redis.sh
# CMD ["redis-server", "/etc/redis/redis.config"]