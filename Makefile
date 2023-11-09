all: up

.PHONY: up
up:
	docker-compose -f srcs/docker-compose.yml up -d --build

.PHONY: stop
stop:
	docker-compose -f srcs/docker-compose.yml stop

.PHONY: down
down:
	docker-compose -f srcs/docker-compose.yml down

.PHONY: down-v
down-v:
	docker-compose -f srcs/docker-compose.yml down -v

.PHONY: clean
clean:
	-docker stop $$(docker ps -a -q)
	-docker rm $$(docker ps -a -q)
	-docker rmi $$(docker images -q)
	-docker volume rm $$(docker volume ls -q)
	-docker builder prune -a -f

.PHONY: logs
logs:
	docker-compose -f srcs/docker-compose.yml logs -f

.PHONY: ps
ps:
	docker-compose -f srcs/docker-compose.yml ps

.PHONY: sh-%
sh-%:
	docker-compose -f srcs/docker-compose.yml exec $* /bin/sh
