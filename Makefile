PASSWORD ?= $(shell stty -echo; read -p "Password: " pwd; stty echo; echo $$pwd)
PATH_TO_DATA = "/home/${USER}/Desktop/data"

all: start

start:
	@mkdir -p ${PATH_TO_DATA}/wp
	@mkdir -p ${PATH_TO_DATA}/db
	@docker-compose -f ./srcs/docker-compose.yml up
# flag -f -  Specify an alternate compose file
stop:
	docker-compose -f ./srcs/docker-compose.yml down

clean: stop
	sudo rm -rf ${PATH_TO_DATA}/wp
	sudo rm -rf ${PATH_TO_DATA}/db
	@docker volume rm $$(docker volume ls -q);
	docker system prune -f

re: clean
	@mkdir -p ${PATH_TO_DATA}/wp
	@mkdir -p ${PATH_TO_DATA}/db
	@docker-compose -f srcs/docker-compose.yml build
	@docker-compose -f srcs/docker-compose.yml up

fclean: stop
	@docker rmi -f $$(docker images -aq)

# docker rm $(docker ps -qa)
# docker network rm $(docker network ls -q)
# prune - удаление неиспользованных данных
# $$(docker ps -qa) - вызов последовательности