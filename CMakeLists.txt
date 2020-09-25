# Mbed CMake Template
# Copyright 2020 Ladislas de Toldi (ladislas [at] detoldi.me)
# SPDX-License-Identifier: Apache-2.0

# mbed-cmake requires at least CMake 3.12
cmake_minimum_required(VERSION 3.12)

# load project upload methods (must be before mbed-cmake is loaded)
# -------------------------------------------------------------
set(ROOT_DIR ${CMAKE_CURRENT_LIST_DIR})
set(MBED_CMAKE_ROOT_DIR ${ROOT_DIR}/cmake)
set(MBED_CMAKE_SCRIPTS_DIR ${MBED_CMAKE_ROOT_DIR}/scripts)
set(MBED_CMAKE_CONFIG_DIR ${MBED_CMAKE_ROOT_DIR}/config)
set(MBED_OS_DIR ${ROOT_DIR}/lib/_vendor/mbed-os)

list(APPEND CMAKE_MODULE_PATH ${MBED_CMAKE_ROOT_DIR})
list(APPEND CMAKE_MODULE_PATH ${MBED_CMAKE_ROOT_DIR/utils})

# load compilers and flags
# -------------------------------------------------------------

include(${ROOT_DIR}/mbed-cmake.cmake)

project(LekaOS LANGUAGES C CXX ASM)

set(LIB_DIR ${ROOT_DIR}/lib)
set(LEKAOS_DIR ${ROOT_DIR}/src)

# recurse to subdirectories
# -------------------------------------------------------------

add_subdirectory(${LIB_DIR}/HelloWorld)
add_subdirectory(${LEKAOS_DIR})

# build report
# -------------------------------------------------------------

mbed_cmake_print_build_report()
