REPO?=master
VPP_VERSION?=

PUSH_TAG?=ligato/vpp-base
IMAGE_TAG?=vpp-base
CONTAINER?=vpp-base

ifeq ($(REPO),master)
PUSH_TAG:=$(PUSH_TAG):latest
IMAGE_TAG:=$(IMAGE_TAG):latest
else
PUSH_TAG:=$(PUSH_TAG):$(REPO)
IMAGE_TAG:=$(IMAGE_TAG):$(REPO)
CONTAINER:=$(CONTAINER).$(REPO)
endif

build:
	@echo "=> Building image.."
	docker build -t ${IMAGE_TAG} --pull \
		--build-arg VPP_REPO=${REPO} \
		--build-arg VPP_VERSION=${VERSION} \
		${DOCKER_BUILD_ARGS} .
	@echo "-> Build OK!"
	@echo " Image size: `docker images --format '{{.Size}}' ${IMAGE_TAG}`"

rebuild: DOCKER_BUILD_ARGS+=--no-cache
rebuild: build
	@echo "=> Rebuild OK!"

push: build
	@echo "=> Tagging image.."
	docker tag ${IMAGE_TAG} ${PUSH_TAG}
	@echo "=> Pushing image.."
	docker push ${PUSH_TAG}

run: start vppctl stop

start:
	@echo "=> Starting container.."
	docker run -d --rm --name ${CONTAINER} ${IMAGE_TAG}
	@echo "-> Start OK!"
	@echo " VPP version: `docker exec -it ${CONTAINER} vppctl show version`"

stop:
	@echo "=> Stopping container.."
	@docker stop ${CONTAINER}

vppctl:
	@docker exec -it ${CONTAINER} vppctl

exec:
	@docker exec -it ${CONTAINER} bash

.PHONY: default \
		build rebuild push test \
		run start stop exec vppctl
