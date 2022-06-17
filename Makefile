all: start

start:
	docker-compose -f ./srcs/docker-compose.yml up
# flag -f -  Specify an alternate compose file
stop:
	docker-compose -f ./srcs/docker-compose.yml down
clean: stop
	docker rm $$(docker ps -qa)
	docker rmi -f $$(docker images -qa)
	docker volume rm $$(docker volume ls -q)
	docker network rm $$(docker network ls -q)
	docker system prune
# prune - удаление неиспользованных данных
# $$(docker ps -qa) - вызов последовательности