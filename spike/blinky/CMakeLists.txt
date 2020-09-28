# Mbed CMake Template
# Copyright 2020 Ladislas de Toldi (ladislas [at] detoldi.me)
# SPDX-License-Identifier: Apache-2.0

add_mbed_executable(blinky)

target_sources(blinky
  PRIVATE
    main.cpp
)

target_include_directories(blinky
  PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}
)
