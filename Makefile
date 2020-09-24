# Mbed CMake Template
# Copyright 2020 Ladislas de Toldi (ladislas [at] detoldi.me)
# SPDX-License-Identifier: Apache-2.0

#
# MARK: - Constants
#

ROOT_DIR  := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
BUILD_DIR := $(ROOT_DIR)/build
MBED_DIR  := $(ROOT_DIR)/lib/_vendor/mbed-os
CMAKE_DIR := $(ROOT_DIR)/cmake

#
# MARK:- Arguments
#

TARGET     ?= DISCO_F769NI
BRANCH     ?= master
BUILD_TYPE ?= Release

#
# MARK:- Targets
#

all:
	ninja -C ./build -f build.ninja

clean:
	rm -rf $(BUILD_DIR)
	rm -rf $(CMAKE_DIR)/config

config:
	@$(MAKE) clean
	mkdir -p $(BUILD_DIR)
	@echo ""
	python3 $(CMAKE_DIR)/scripts/configure_cmake_for_target.py $(TARGET) -p $(CMAKE_DIR)/config
	@echo "\n"
	@cd $(BUILD_DIR); cmake -GNinja -DCMAKE_BUILD_TYPE=$(BUILD_TYPE) ..

clone_mbed:
	rm -rf $(MBED_DIR)
	@echo ""
	git clone --depth=1 --branch=$(BRANCH) https://github.com/ARMmbed/mbed-os $(MBED_DIR)
	@echo ""
	cp $(CMAKE_DIR)/MbedOS_CMakeLists.txt $(MBED_DIR)/CMakeLists.txt

