# Mbed CMake Template
# Copyright 2020 Ladislas de Toldi (ladislas [at] detoldi.me)
# SPDX-License-Identifier: Apache-2.0

add_library(lib_hello_world STATIC)

target_sources(lib_hello_world
  PRIVATE
    HelloWorld.cpp
)

target_include_directories(lib_hello_world
  PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
)

target_link_libraries(lib_hello_world mbed-os)
