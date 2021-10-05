# Mbed CMake Template
# Copyright 2020 Ladislas de Toldi (ladislas [at] detoldi.me)
# SPDX-License-Identifier: Apache-2.0

add_executable(boink)

mbed_configure_app_target(boink)

target_sources(boink
    PRIVATE
        main.cpp
)

target_link_libraries(boink
	PRIVATE
        mbed-os-lib
)

mbed_set_post_build(boink)
