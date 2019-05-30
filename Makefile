REPO?=
VPP_VERSION?=

DOCKER_REPO?=vpp-base
TAG?=

IMAGE_TAG=$(DOCKER_REPO):$(TAG)

image: build

build:
	@echo "# Building image $(IMAGE_TAG).."
	docker build \
		--build-arg REPO=${REPO} \
		--build-arg VPP_VERSION=${VPP_VERSION} \
		--tag ${IMAGE_TAG} \
		${DOCKER_BUILD_ARGS} .
	@echo "# Build OK! Image: `docker images --format '{{.Repository}}:{{.Tag}} ({{.Size}})' ${IMAGE_TAG}`"

push:
	@echo "# Pushing image $(IMAGE_TAG).."
	docker push ${IMAGE_TAG}

.PHONY: image build push
