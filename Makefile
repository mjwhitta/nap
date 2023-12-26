VERSION := $(shell cat ./root/nap/sys/version)
VERSION := $(subst v,,$(VERSION))
MAJOR := $(firstword $(subst ., ,$(VERSION)))
VERSION := $(subst $(MAJOR).,,$(VERSION))
MINOR := $(firstword $(subst ., ,$(VERSION)))
MINOR := $(shell echo "$$(($(MINOR)+1))")
VERSION :=

all:
	@./build

bump:
	@echo "v$(MAJOR).$(MINOR).0" >./root/nap/sys/version
	@git commit -am "Bumped version"
	@git tag v$(MAJOR).$(MINOR).0
	@git push
	@git push --tags

clean:
	docker rmi ghcr.io/mjwhitta/nap:latest
