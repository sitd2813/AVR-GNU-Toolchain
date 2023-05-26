# AVR GNU Toolchain

This repository contains a Makefile to build native AVR GNU Toolchain and AVR GNU Toolchain for 64-bit Windows.

| Tool             | Version | Date       |
|:----------------:|:-------:|:----------:|
| AVR GNU Binutils | 2.40    | 2023-01-16 |
| AVR GDB          | 13.1    | 2023-02-19 |
| AVR GCC          | 12.2.0  | 2022-08-19 |
| AVR LibC         | 2.1.0   | 2022-01-14 |

## 1. Prerequisites

- Common prerequisites

  ```sh
  sudo apt install build-essential mingw-w64 texinfo wget
  ```

- Prerequisites to build native AVR GDB

  ```sh
  sudo apt install libgmp-dev liblzma-dev libxxhash-dev
  ```

## 2. Build instructions

### 2.1. Configuring the build

Edit the `VERSION_<TOOL>` and `CONFIGURE_<TOOL>_OPTIONS` variables at the top of the Makefile to change the version of the tool and its configuration options.

### 2.2. Using preinstalled AVR GNU toolchain

- `WITH_PREINSTALLED` (Default: `false`)

  By default, the Makefile will build the toolchain alongside its dependencies. For example, `make avr-gcc-amd64-windows` will build native AVR GCC and AVR GNU Binutils before building AVR GCC for Windows.

  | Tool                | Dependencies                        |
  |:-------------------:|:-----------------------------------:|
  | native AVR GCC      | native AVR GNU Binutils             |
  | AVR GCC for Windows | native AVR GNU Binutils and AVR GCC |
  | AVR LibC            | native AVR GNU Binutils and AVR GCC |

  If you already have the dependencies installed, you can use `make <COMMAND> WITH_PREINSTALLED=true` to skip building dependencies.

### 2.3. Build commands

- `make` (Default)

- `make all-(native|amd64-windows)`

- `make avr-binutils-(native|amd64-windows)`

- `make avr-gdb-(native|amd64-windows)`

- `make avr-gcc-(native|amd64-windows)`

- `make avr-libc`

## 3. Things to note

- **IMPORTANT**: The path to the Makefile must not contain spaces, or the build will fail.

- **IMPORTANT**: For Debian users, the `gcc-avr` package won't work as the version is too old (5.4.0 as of 2023-03-21). You must build the dependencies first.

- Redirecting the output of Make as `make &> build.log` is recommended since the build process might fail sometimes.

## 4. Releases

Builds of AVR GNU Toolchain will be uploaded to the [GitHub releases page](https://github.com/sitd2813/AVR-GNU-Toolchain/releases).

This will also contain additional tools listed below.

- [AVRDUDE for Windows](https://github.com/mariusgreuel/avrdude)
