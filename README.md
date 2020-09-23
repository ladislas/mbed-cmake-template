# Mbed CMake Template

## Introduction

This repository can be used as a starting template for [mbed](https://github.com/ARMmbed/mbed-os) projects with sane defaults:

- simple directory structure
- CMake based with [USCRPL/mbed-cmake](https://github.com/USCRPL/mbed-cmake/)
- Code completion with VSCode + [CMake Tools](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cmake-tools)
- format with `.clang-format` and `.editorconfig`

*Note: you should be able to use [mbed-cli](https://github.com/ARMmbed/mbed-cli) if you want.*

## How to install

Before starting, make sure you've read the [mbed documentation](https://os.mbed.com/docs/mbed-os/v6.1/introduction/index.html).

### 0. Clone the repository

To start with:

```bash
# Clone the repository
$ git clone https://github.com/ladislas/mbed-cmake-template && cd mbed-cmake-template

# Clone Mbed OS using the Makefile
$ make clone_mbed

# You can specify a branch (default is master)
$ make clone_mbed BRANCH=mbed-os-6.3.0
```

### 1. Install mbed-cli & co.

I recommend the manual install. Make sure to follow the instructions from mbed:

> https://os.mbed.com/docs/mbed-os/v6.3/build-tools/install-and-set-up.html

```bash
# For the latest stable version
$ python3 -m pip install -U --user mbed-cli

# For HEAD
$ python3 -m pip install -U --user https://github.com/ARMmbed/mbed-cli/archive/master.zip
```

Then, install the required tools:

```bash
# First, important packages
$ python3 -m pip install -U --user pyserial intelhex prettytable

# And finally mbed-cli requirements
$ python3 -m pip install -U --user lib/_vendor/mbed-os/requirements.txt
```

### 2. Install arm-none-eabi-gcc

#### For macOS:

```bash
$ brew tap ArmMbed/homebrew-formulae
$ brew install arm-none-eabi-gcc
```

#### For Windows & Linux:

You can download the toolchain here:

> https://developer.arm.com/tools-and-software/open-source-software/developer-tools/gnu-toolchain/gnu-rm/downloads

## How to use

We put together an handy [`Makefile`](./Makefile) to make it easier to configure and compile your projects.

```bash
# First, you need to clone mbed-os
$ make clone_mbed

# You can specify a branch (default is master)
$ make clone_mbed BRANCH=mbed-os-6.3.0

# Then configure for your target
$ make config TARGET=DISCO_F769NI

# You can also specify a build type
$ make config TARGET=DISCO_F769NI BUILD_TYPE=Debug

# Finally, to compile your project
$ make
```

## Multiple apps & tests

> coming soon...

## Notes

The template comes with a simple [`HelloWorld`](./lib/HelloWorld) library that you can use as an example and/or use to make sure your program works.

## Bugs & Contributing

Please open an issue or create a PR.

## Authors

Made with ❤️ by:

- **Ladislas de Toldi** - [ladislas](https://github.com/ladislas)

This work is heavily inspired by [USCRPL/mbed-cmake](https://github.com/USCRPL/mbed-cmake/) and code written by:

- **Jamie Smith** - [multiplemonomials](https://github.com/multiplemonomials)
- **ProExpertProg** - [ProExpertProg](https://github.com/ProExpertProg)

## License

Apache 2.0 @ Ladislas de Toldi (Ladislas [at] detoldi dot me)
