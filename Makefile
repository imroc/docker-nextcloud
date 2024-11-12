SHELL := /bin/bash

IMAGE ?= docker.io/imroc/nextcloud
VERSION ?= $(shell cat VERSION)
MAJOR_MINOR := $(shell echo $(VERSION) | cut -d '.' -f1,2)
MAJOR := $(shell echo $(VERSION) | cut -d '.' -f1)

all: build major-minor major latest

build:
	docker buildx build --push --build-arg VERSION=$(VERSION) --platform linux/amd64,linux/arm64,linux/ppc64le,linux/s390x -t $(IMAGE):$(VERSION) .

major:
	docker tag $(IMAGE):$(VERSION) $(IMAGE):$(MAJOR)
	docker push $(IMAGE):$(MAJOR)

major-minor:
	docker tag $(IMAGE):$(VERSION) $(IMAGE):$(MAJOR_MINOR)
	docker push $(IMAGE):$(MAJOR_MINOR)

latest:
	docker tag $(IMAGE):$(VERSION) $(IMAGE):latest
	docker push $(IMAGE):latest
