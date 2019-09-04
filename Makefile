REPO?=release
VPP_VERSION?=

DOCKER_REPO?=vpp-base
TAG?=latest

IMAGE_TAG=$(DOCKER_REPO):$(TAG)

image: build

build:
	@echo "# Building image: $(IMAGE_TAG)"
	docker build \
		--build-arg REPO="$(REPO)" \
		--build-arg VPP_VERSION="$(VPP_VERSION)" \
		--tag $(IMAGE_TAG) \
		${DOCKER_BUILD_ARGS} .
	@echo "# Build OK! Image: `docker images --format '{{.Repository}}:{{.Tag}} ({{.Size}})' ${IMAGE_TAG}`"

push: VPP_VERSION=$(shell docker run --rm $(IMAGE_TAG) cat /vpp/version | cut -d'~' -f1,2 | sed -e 's/~/./g')
push:
	@echo "# Pushing image: $(IMAGE_TAG) - $(DOCKER_REPO):$(VPP_VERSION)"
	@curl -sSflL "https://index.docker.io/v1/repositories/$(DOCKER_REPO)/tags/$(VPP_VERSION)" || \
	( \
		set -Eexu; \
		docker tag "$(IMAGE_TAG)" "$(DOCKER_REPO):$(VPP_VERSION)"; \
		docker push "$(DOCKER_REPO):$(VPP_VERSION)"; \
		docker push "$(IMAGE_TAG)"; \
		echo "# Push OK!"; \
	)

.PHONY: image build push
