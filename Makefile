VERSION := $(shell cat ./root/nap/sys/version)
VERSION := $(subst v,,$(VERSION))
MAJOR := $(firstword $(subst ., ,$(VERSION)))
VERSION := $(subst $(MAJOR).,,$(VERSION))
MINOR := $(firstword $(subst ., ,$(VERSION)))
VERSION := $(subst $(MINOR).,,$(VERSION))
BUILD := $(firstword $(subst ., ,$(VERSION)))
NEWBUILD := $(shell echo "$$(($(BUILD)+1))")
VERSION :=

all:
	@./build

bump:
	@echo "v$(MAJOR).$(MINOR).$(NEWBUILD)" >./root/nap/sys/version
	@git commit -am "Bumped version"
	@git tag v$(MAJOR).$(MINOR).$(NEWBUILD)
	@git push
	@git push --tags

clean:
	docker rmi ghcr.io/mjwhitta/nap:latest

release:
	@git tag v$(MAJOR).$(MINOR).$(BUILD)
	@git push
	@git push --tags
