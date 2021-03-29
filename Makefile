default: all

PRJTAG := ly10_system_rpi3

MIX_TARGET := ly10_rpi3

DOCKER_TARGET ?= dist

GIT_DESC := $(shell git describe --tags --always --dirty --match "v[0-9]*")
VERSION_TAG := $(patsubst v%,%,$(GIT_DESC))

BASE_PATH := $(realpath .)
DIST := $(BASE_PATH)/dist

VERSION_FILE = VERSION
VERSION_NUM = `cat $(VERSION_FILE)`

ARTIFACT_DIR := $(BASE_PATH)/.nerves/artifacts/$(PRJTAG)-portable-$(VERSION_NUM)

.PHONY: clean
clean:
	-rm build.log
	-rm archive.log
	-rm -rf .nerves/artifacts
	-rm -rf _build

.PHONY: versions
versions:
		@echo "GIT_DESC: $(GIT_DESC)"
		@echo "VERSION_TAG: $(VERSION_TAG)"
		@echo "$(ARTIFACT_DIR)"


build-prep:
	-mkdir -p ./.nerves/artifacts

.PHONY: lint
lint:
	mix nerves.system.lint nerves_defconfig

install-hex-rebar:
	mix local.hex --force && \
	mix local.rebar --force

install-dependencies:
	MIX_TARGET=$(MIX_TARGET) mix deps.get

install-nerves-bootstrap:
	mix archive.install git https://github.com/nerves-project/nerves_bootstrap.git tag v1.10.1 --force

.PHONY: install-prep
install-prep: install-hex-rebar install-nerves-bootstrap

.PHONY: build
build: versions install-prep install-dependencies build-prep
	mix compile

.PHONY: build-test-app
build-test-app: install-prep
	cd ./plt_test_app && ./keys.sh &&  MIX_TARGET=$(MIX_TARGET) mix do deps.get, firmware

.PHONY: dist-test-app
dist-test-app: build-test-app dist-prep
	cp ./plt_test_app/_build/ly10_rpi3_dev/nerves/images/plt_test.fw $(DIST)/plt_test_$(VERSION_TAG).fw

dist-prep:
	-mkdir $(DIST)

.PHONY: dist-clean
dist-clean:
	-rm -rf $(DIST)

.PHONY: dist
dist: dist-prep build
	[ -d $(ARTIFACT_DIR) ] && \
		MIX_TARGET=$(MIX_TARGET) fakeroot mix nerves.artifact $(PRJTAG) --path $(DIST) \
		|| echo 'Skipping previously artifact'

.PHONY: docker
docker: clean
	docker build --network=host -t "bcdevices/$(PRJTAG)" .
	-docker rm -f "$(PRJTAG)"
	docker run --name "$(PRJTAG)" --network=host -v $$HOME/.nerves/dl:/root/.nerves/dl -t "bcdevices/$(PRJTAG)" /bin/bash -c 'MIX_TARGET=ly10_rpi3 make $(DOCKER_TARGET)'
	-docker cp "$(PRJTAG):/nerves-system/dist" $(BASE_PATH)

all: build

