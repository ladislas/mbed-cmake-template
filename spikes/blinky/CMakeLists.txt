# Mbed CMake Template
# Copyright 2020 Ladislas de Toldi (ladislas [at] detoldi.me)
# SPDX-License-Identifier: Apache-2.0

add_executable(blinky)

mbed_configure_app_target(blinky)

target_sources(blinky
    PRIVATE
        main.cpp
)

target_link_libraries(blinky
	PRIVATE
        mbed-os
)

mbed_set_post_build(blinky)
