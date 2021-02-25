# Mbed CMake Template
# Copyright 2020 Ladislas de Toldi (ladislas [at] detoldi.me)
# SPDX-License-Identifier: Apache-2.0

add_executable(main_program)

mbed_configure_app_target(main_program)

target_sources(main_program
    PRIVATE
        main.cpp
)

target_link_libraries(main_program
	PRIVATE
		HelloWorld
        mbed-os
)

mbed_set_post_build(main_program)
