REPO?=master
VERSION?=

ifeq ($(REPO),master)
IMAGE_TAG=vpp-base:latest
else
IMAGE_TAG=vpp-base:${REPO}
endif

CONTAINER_NAME?=vpp-base

default: build

build:
	@echo "=> building image.. ${IMAGE_TAG}"
	docker build -t ${IMAGE_TAG} \
		--build-arg VPP_REPO=${REPO} \
		--build-arg VPP_VERSION=${VERSION} \
		${DOCKER_BUILD_ARGS} .
	@echo "-> build OK!"
	@echo " Image size: `docker images --format '{{.Size}}' ${IMAGE_TAG}`"

rebuild: DOCKER_BUILD_ARGS+=--no-cache
rebuild: build
	@echo "=> rebuild OK!"

run: start vppctl

start:
	@echo "=> starting container.. ${CONTAINER_NAME}"
	@docker run -d --rm --name ${CONTAINER_NAME} -v /run/vpp-agent:/run ${IMAGE_TAG}
	@echo "-> start OK!"
	@echo " VPP version: `docker exec -it ${CONTAINER_NAME} vppctl show version`"
	
exec:
	@docker exec -it ${CONTAINER_NAME} bash

vppctl:
	@docker exec -it ${CONTAINER_NAME} vppctl

stop:
	@echo "=> stopping container.."
	@docker stop ${CONTAINER_NAME}

.PHONY: default \
	build rebuild \
	run start exec vppctl stop
