# Mbed CMake Template
# Copyright 2020 Ladislas de Toldi (ladislas [at] detoldi.me)
# SPDX-License-Identifier: Apache-2.0

add_mbed_executable(leka_os)

target_sources(leka_os
  PRIVATE
    main.cpp
)

target_include_directories(leka_os
  PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}
)

target_link_libraries(leka_os lib_hello_world)
