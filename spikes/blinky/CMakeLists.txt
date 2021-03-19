# Mbed CMake Template
# Copyright 2020 Ladislas de Toldi (ladislas [at] detoldi.me)
# SPDX-License-Identifier: Apache-2.0

add_executable(blinky)

mbed_configure_app_target(blinky)
mbed_set_mbed_target_linker_script_patched(blinky)

target_sources(blinky
    PRIVATE
        main.cpp
)

target_link_libraries(blinky
	PRIVATE
		mbed_for_my_app
)

mbed_set_post_build(blinky)
