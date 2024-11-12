SHELL := /bin/bash

IMAGE ?= docker.io/imroc/nextcloud
GIT_TAG ?= $(shell git describe --abbrev=0 --tags)
VERSION = $(GIT_TAG:v%=%)

all: build latest

build:
	docker buildx build --push --build-arg VERSION=$(VERSION) --platform linux/amd64,linux/arm64,linux/ppc64le,linux/s390x -t $(IMAGE):$(VERSION) .

latest:
	docker tag $(IMAGE):$(VERSION) $(IMAGE):latest
	docker push $(IMAGE):latest
