default: all

PRJTAG := ly10_system_rpi3

MIX_TARGET := ly10_rpi3

GIT_DESC := $(shell git describe --tags --always --dirty --match "sc[0-9]*")
VERSION_TAG := $(patsubst sc%,%,$(GIT_DESC))

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
	cd /tmp && \
	mix local.hex --force && \
	mix local.rebar --force

install-dependencies:
	MIX_TARGET=$(MIX_TARGET) mix deps.get

install-nerves-bootstrap:
	cd /tmp &&  \
	mix archive.install git https://github.com/nerves-project/nerves_bootstrap.git tag v1.5.0 --force

.PHONY: build
build: versions install-hex-rebar install-nerves-bootstrap install-dependencies build-prep
	mix compile

dist-prep:
	-mkdir $(DIST)

.PHONY: dist-clean
dist-clean:
	-rm -rf $(DIST)

.PHONY: dist
dist: dist-prep build
	[ -d $(ARTIFACT_DIR) ] && \
		MIX_TARGET=$(MIX_TARGET) mix nerves.artifact $(PRJTAG) --path $(DIST) \
		|| echo 'Skipping previously artifact'

.PHONY: docker
docker: clean
	docker build --network=host -t "bcdevices/$(PRJTAG)
	-docker rm -f "$(PRJTAG)"
	docker run --name "$(PRJTAG)" --network=host -v $$HOME/.nerves/dl:/root/.nerves/dl -t "bcdevices/$(PRJTAG)" /bin/bash -c 'MIX_TARGET=ly10_rpi3 make dist'
	-docker cp "$(PRJTAG):/nerves-system/dist" $(BASE_PATH)

all: build

