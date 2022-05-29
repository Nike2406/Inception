all: start

start:
	docker-compose -f ./srcs/docker-compose.yml up
# flag -f -  Specify an alternate compose file
stop:
	docker-compose -f ./srcs/docker-compose.yml down
clean:
	stop
	docker system prune
# prune - удаление неиспользованных данных