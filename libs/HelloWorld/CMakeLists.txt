# Mbed CMake Template
# Copyright 2020 Ladislas de Toldi (ladislas [at] detoldi.me)
# SPDX-License-Identifier: Apache-2.0

add_library(HelloWorld STATIC)

target_include_directories(HelloWorld
	PUBLIC
		.
)

target_sources(HelloWorld
	PRIVATE
		HelloWorld.cpp
)

target_link_libraries(HelloWorld
	PRIVATE
		mbed-os-lib
)
