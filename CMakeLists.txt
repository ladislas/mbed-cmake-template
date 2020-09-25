# Mbed CMake Template
# Copyright 2020 Ladislas de Toldi (ladislas [at] detoldi.me)
# SPDX-License-Identifier: Apache-2.0

# mbed-cmake requires at least CMake 3.12
cmake_minimum_required(VERSION 3.12)

# load compilers and flags
# -------------------------------------------------------------

include(./mbed-cmake.cmake)

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
