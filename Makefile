all: start

start:
	@mkdir -p /home/${USER}/data/wp
	@mkdir -p /home/${USER}/data/db
	docker-compose -f ./srcs/docker-compose.yml up
# flag -f -  Specify an alternate compose file
stop:
	docker-compose -f ./srcs/docker-compose.yml down
clean: stop
	sudo rm -rf /home/${USER}/data/wp
	sudo rm -rf /home/${USER}/data/db
	@ docker volume rm $$(docker volume ls -q);
	docker system prune 

re: 
	@mkdir -p /home/${USER}/data/wp
	@mkdir -p /home/${USER}/data/db
	@docker-compose -f srcs/docker-compose.yml build
	docker-compose -f srcs/docker-compose.yml up

# @ docker rmi -f $$(docker images -qa);
# docker rm $(docker ps -qa)
# docker network rm $(docker network ls -q)
# prune - удаление неиспользованных данных
# $$(docker ps -qa) - вызов последовательности