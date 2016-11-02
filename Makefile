.PHONE: build push

TAG=latest
USER=taller
REPO=$(notdir $(CURDIR))

run:
	docker run --rm -it $(USER)/$(REPO) /bin/bash

pull:
	docker pull $(USER)/$(REPO):$(TAG)

build:
	docker build -t $(USER)/$(REPO):$(TAG) .

push:
	$(error Docker Hub automated build is configured; use Git push to trigger a new build.)
