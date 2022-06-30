PASSWORD ?= $(shell stty -echo; read -p "Password: " pwd; stty echo; echo $$pwd)

all: start

start:
	@mkdir -p /home/${USER}/Desktop/data/wp
	@mkdir -p /home/${USER}/Desktop/data/db
	@docker-compose -f ./srcs/docker-compose.yml up
# flag -f -  Specify an alternate compose file
stop:
	docker-compose -f ./srcs/docker-compose.yml down

clean: stop
	rm -rf /home/${USER}/Desktop/data/wp
	rm -rf /home/${USER}/Desktop/data/db
	@docker volume rm $$(docker volume ls -q);
	docker system prune -f

re: clean
	@mkdir -p /home/${USER}/Desktop/data/wp
	@mkdir -p /home/${USER}/Desktop/data/db
	@docker-compose -f srcs/docker-compose.yml build
	@docker-compose -f srcs/docker-compose.yml up

fclean: clean
	@docker rmi -f $$(docker images -qa);

# docker rm $(docker ps -qa)
# docker network rm $(docker network ls -q)
# prune - удаление неиспользованных данных
# $$(docker ps -qa) - вызов последовательности