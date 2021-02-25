# Mbed CMake Template
# Copyright 2020 Ladislas de Toldi (ladislas [at] detoldi.me)
# SPDX-License-Identifier: Apache-2.0

cmake_minimum_required(VERSION 3.19)

# Activate ccache
find_program(CCACHE "ccache")
if(CCACHE)
    set(CMAKE_C_COMPILER_LAUNCHER ${CCACHE})
    set(CMAKE_CXX_COMPILER_LAUNCHER ${CCACHE})
endif()

# Set ROOT_DIR, MBED_PATH, MBED_CONFIG_PATH
set(ROOT_DIR         ${CMAKE_CURRENT_LIST_DIR})
set(MBED_PATH        ${ROOT_DIR}/extern/mbed-os CACHE INTERNAL "")
set(MBED_CONFIG_PATH ${ROOT_DIR}/.mbedbuild CACHE INTERNAL "")

# For convenience, define useful variables
set(LIBS_DIR    ${ROOT_DIR}/libs)
set(SPIKES_DIR  ${ROOT_DIR}/spikes)
set(TARGETS_DIR ${ROOT_DIR}/targets)

# Generate compile commands database
set(CMAKE_EXPORT_COMPILE_COMMANDS ON CACHE INTERNAL "")

# Include mbed os cmake logic
include(${MBED_PATH}/tools/cmake/app.cmake)

# Colored output when compiling
add_compile_options(-fdiagnostics-color)

# 💡 Set project name and languages
project("Mbed CMake Template" LANGUAGES C CXX ASM)

# Add mbed-os
add_subdirectory(${MBED_PATH})

# Add libraries
add_subdirectory(${LIBS_DIR}/HelloWorld)

# Add executable targets main & blinky (as spike)
# 💡 You can uncomment both lines to make it fail
add_subdirectory(${ROOT_DIR}/src)
# add_subdirectory(${SPIKES_DIR}/blinky)

option(VERBOSE_BUILD "Have a verbose build process")
if(VERBOSE_BUILD)
    set(CMAKE_VERBOSE_MAKEFILE ON)
endif()
