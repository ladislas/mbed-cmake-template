ROOT_DIR  := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
BUILD_DIR := $(ROOT_DIR)/build
MBED_DIR  := $(ROOT_DIR)/lib/_vendor/mbed-os

all:
	ninja -C ./build -f build.ninja

config:
	@cd $(BUILD_DIR); cmake -GNinja -DCMAKE_BUILD_TYPE=Release ..

clean: clean_config
	rm -rf $(BUILD_DIR)

build_dir:
	mkdir -p $(BUILD_DIR)

config_target: clean
	mkdir -p $(BUILD_DIR)
	python3 $(ROOT_DIR)/scripts/configure_cmake_for_target.py $(target) -p $(ROOT_DIR)/cmake/config

clean_config:
	rm -rf $(ROOT_DIR)/cmake/config

clone_mbed:
	rm -rf $(MBED_DIR)
	git clone --depth=1 --branch=mbed-os-6.3.0 https://github.com/ARMmbed/mbed-os $(MBED_DIR)

clone_mbed_master:
	rm -rf $(MBED_DIR)
	git clone --depth=1 --branch=master        https://github.com/ARMmbed/mbed-os $(MBED_DIR)
