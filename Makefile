all: start

start:
	docker-compose -f ./srcs/docker-compose.yml up
stop:
	docker-compose -f ./srcs/docker-compose.yml down
clean:
	stop
	docker system prune