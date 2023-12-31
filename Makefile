include srcs/.env
export

all: up

.PHONY: up
up:
	mkdir -p ${DATA_DB} ${DATA_WP}
	docker compose -f srcs/docker-compose.yml up -d --build

.PHONY: stop
stop:
	docker compose -f srcs/docker-compose.yml stop

.PHONY: down
down:
	docker compose -f srcs/docker-compose.yml down -v

.PHONY: logs
logs:
	docker compose -f srcs/docker-compose.yml logs -f

.PHONY: ps
ps:
	docker compose -f srcs/docker-compose.yml ps

.PHONY: sh-%
sh-%:
	docker compose -f srcs/docker-compose.yml exec $* /bin/sh

.PHONY: clean
clean:
	-docker stop $$(docker ps -a -q)
	-docker rm $$(docker ps -a -q)
	-docker rmi $$(docker images -q)
	-docker volume rm $$(docker volume ls -q)
	-docker network rm $$(docker network ls -q) 2>/dev/null
	-docker buildx prune -a -f 2>/dev/null
	sudo rm -rf ${DATA_DB} ${DATA_WP}

.PHONY: clean-eval
clean-eval:
	-docker stop $$(docker ps -qa)
	-docker rm $$(docker ps -qa)
	-docker rmi -f $$(docker images -qa)
	-docker volume rm $$(docker volume ls -q)
	-docker network rm $$(docker network ls -q) 2>/dev/null
