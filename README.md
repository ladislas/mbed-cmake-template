# Mbed CMake Template

**Version: 1.0.0**

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
$ python3 -m pip install -U --user -r lib/_vendor/mbed-os/requirements.txt
```

### 2. Install arm-none-eabi-gcc & tools

#### For macOS:

```bash
# Install arm-gcc
$ brew tap ArmMbed/homebrew-formulae
$ brew install arm-none-eabi-gcc

# Install Ninja (for building)
$ brew install ninja
```

#### For Windows & Linux:

You can download the toolchain here:

> https://developer.arm.com/tools-and-software/open-source-software/developer-tools/gnu-toolchain/gnu-rm/downloads

And for Ninja, follow the documentation:

> https://ninja-build.org/

## How to use

We put together an handy [`Makefile`](./Makefile) to make it easier to configure and compile your projects.

```bash
# First, you need to clone mbed-os
$ make clone_mbed

# You can specify a branch (default is master)
$ make clone_mbed BRANCH=mbed-os-6.3.0

# Then configure for your target
$ make config TARGET_BOARD=DISCO_F769NI

# You can also specify a build type (default is Release)
$ make config TARGET_BOARD=DISCO_F769NI BUILD_TYPE=Debug

# Finally, to compile your project
$ make
```

### Using `.mbedignore`

To speed up compilation time, we've setup an [`.mbedignore`](./cmake/templates/Template_MbedOS_mbedignore.txt) file that removes some files from the compilation process.

If you get error about missing headers when compiling, make sure the header's directory is not set in the `.mbedignore` file.

You can edit the `.mbedignore` file here: (it is symlinked to the mbed-os directory)

> [`.cmake/templates/Template_MbedOS_mbedignore.txt`](./cmake/templates/Template_MbedOS_mbedignore.txt)

### Mbed CLI & `.mbed`

If you want to use [mbed-cli](https://github.com/ARMmbed/mbed-cli), you can set your target and favorite toolchain in the [`.mbed`](./.mbed) file:

```bash
MBED_OS_DIR=./lib/_vendor/mbed-os
TARGET=DISCO_F769NI
TOOLCHAIN=GCC_ARM
ROOT=.
```

### Flashing the board

In the [`Makefile`](./Makefile) we also provide a `flash` target. It simply copies the `.bin` file to your [Mbed Enabled](https://os.mbed.com/mbed-enabled/introduction/) board.

```makefile
flash:
	@diskutil list | grep "DIS_F769NI" | awk '{print $$5}' | xargs -I {} diskutil unmount '/dev/{}'
	@diskutil list | grep "DIS_F769NI" | awk '{print $$5}' | xargs -I {} diskutil mount   '/dev/{}'
	cp build/$(PROGRAM) /Volumes/DIS_F769NI
```

You **must** edit the Makefile to suit your needs:

- change the `DIS_F769NI` to your board id
- change the path of the volume
- use `fdisk` on Linux instead of `diskutil`

If you need something more complex, it should be easier to provide a script that you can call from the Makefile.

## Multiple apps, spikes & tests

The main idea behind this template is to have your main source files (those for the big project you're working on) under the [`./src`](./src) directory.

Now, you sometimes need to create a simple, very basic example project to test a new features, investigate a bug or try a different solution to a problem.

These can be added to the [`spike`](./spike) directory inside their own directory. You'll need at leat a `main.cpp` and a `CMakeLists.txt`. See [`blinky`](./spike/blinky) for a working example.

## Custom targets

If you need to use a custom target, you can add it to the [`target`](./target) directory and edit the [`custom_targets.json`](./targets/custom_targets.json) file.

Then, you need to configure the project with the following:

```bash
# Run config script with "-x TARGET_BOARD_NAME"
$ make config TARGET_BOARD="-x DISCO_ORIGINAL"
```

**Don't forget the `-x`**, it's really important as it tells the config script to look for headers and sources files in the `targets` directory.

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
