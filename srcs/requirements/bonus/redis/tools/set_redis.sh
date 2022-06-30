#!/bin/bash

echo "Redis: Trying to set up redis"
if [ ! -f "/etc/redis/redis.conf.bak" ]; then
    cp /etc/redis/redis.conf /etc/redis/redis.conf.bak

    echo "Redis: Start to set"
    sed -i "s|supervised no|supervised systemd|g"  /etc/redis/redis.conf
    sed -i "s|#bind 127.0.0.1|bind 127.0.0.1|g" /etc/redis/redis.conf
    # foobar -> password
    sed -i "s|# requirepass foobar|requirepass $REDIS_PWD|g" /etc/redis/redis.conf
    sed -i "s|# maxmemory <bytes>|maxmemory 2mb|g" /etc/redis/redis.conf
    sed -i "s|# maxmemory-policy noevicrion|maxmemory-policy allkeys-lru|g" /etc/redis/redis.conf
    redis-server /etc/redis/redis.config
    echo "Redis: Set up finished"
else
    echo "Redis: setup already exists!"
fi

redis-server --protected-mode no
