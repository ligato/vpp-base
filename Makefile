IMAGE_TAG=vpp-base:latest
CONTAINER_NAME?=vpp-base
REPO=master

default: build run

build:
	@echo "=> building image.."
	@docker build -t ${IMAGE_TAG} ${DOCKER_BUILD_ARGS} .
	@echo "\n=> build OK!"
	@echo " Image size: `docker images --format '{{.Size}}' ${IMAGE_TAG}`"

rebuild: DOCKER_BUILD_ARGS+=--no-cache
rebuild: build
	@echo "=> rebuild OK!"

run: start vppctl stop

start:
	@echo "=> starting container.."
	@docker run -d --rm --name ${CONTAINER_NAME} ${IMAGE_TAG}
	@echo "\n=> start OK!"
	@echo " VPP version: `docker exec -it ${CONTAINER_NAME} vppctl show version`"
	
vppctl:
	@docker exec -it ${CONTAINER_NAME} vppctl

stop:
	@echo "=> stopping container.."
	@docker stop ${CONTAINER_NAME}

.PHONY: default \
	build rebuild \
	run start vppctl stop

