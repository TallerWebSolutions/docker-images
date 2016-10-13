.PHONE: build push

TAG=latest
USER=lucasconstantino
REPO=$(notdir $(CURDIR))

run:
	docker run --rm -it $(USER)/$(REPO) /bin/bash

build:
	docker build -t $(USER)/$(REPO):$(TAG) .

push: build
	docker push $(USER)/$(REPO):$(TAG)
