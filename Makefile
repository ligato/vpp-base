REPO?=master
VPP_VERSION?=

IMAGE?=vpp-base

ifeq ($(REPO),master)
TAG:=latest
else
TAG:=$(REPO)
endif

IMAGE_TAG=$(IMAGE):$(TAG)

image:
	@echo "=> Building image.."
	docker build -f Dockerfile \
		--build-arg REPO=${REPO} \
		--build-arg VPP_VERSION=${VPP_VERSION} \
		--tag ${IMAGE_TAG} \
		${DOCKER_BUILD_ARGS} .
	@echo "=> Build OK! Image: `docker images --format '{{.Repository}}:{{.Tag}} ({{.Size}})' ${IMAGE_TAG}`"

push: PUSH_TAG=ligato/$(IMAGE_TAG)
push:
	@echo "=> Tagging image.."
	docker tag ${IMAGE_TAG} ${PUSH_TAG}
	@echo "=> Pushing image.."
	docker push ${PUSH_TAG}

.PHONY: image push
