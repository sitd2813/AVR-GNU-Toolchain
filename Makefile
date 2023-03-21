#!/usr/bin/make -f

# ----------- User options ----------- #
# <https://ftp.gnu.org/gnu/binutils/>: 2.40 (2023-01-16)
VERSION_BINUTILS = 2.40
CONFIGURE_BINUTILS_OPTIONS = \
--enable-shared\
--disable-static\
--enable-colored-disassembly\
--enable-plugins

# <https://ftp.gnu.org/gnu/gdb/>: 13.1 (2023-02-19)
VERSION_GDB = 13.1
CONFIGURE_GDB_OPTIONS = \
--disable-shared\
--enable-static\
--disable-install-libbfd\
--with-lzma\
--with-xxhash\
--with-static-standard-libraries

# Dependency of AVR GDB for Windows
# <https://ftp.gnu.org/gnu/gmp/>: 6.2.1 (2020-11-14)
VERSION_GMP = 6.2.1
# <https://tukaani.org/xz/>: 5.4.2 (2023-03-18)
VERSION_XZ = 5.4.2
# <https://github.com/Cyan4973/xxHash> 0.8.1 (2021-11-30)
VERSION_XXHASH = 0.8.1

# <https://ftp.gnu.org/gnu/gcc/>: 12.2.0 (2022-08-19)
VERSION_GCC = 12.2.0
CONFIGURE_GCC_OPTIONS = \
--disable-shared\
--enable-static\
--enable-languages=c,lto\
--enable-lto\
--enable-plugin

# <https://download.savannah.gnu.org/releases/avr-libc/>: 2.1.0 (2022-01-14)
VERSION_AVR_LIBC = 2.1.0
CONFIGURE_AVR_LIBC_OPTIONS =
# ------------------------------------ #

VERSION_TOOLCHAIN = 1.0.0

TRIPLET_AMD64_WINDOWS = x86_64-w64-mingw32
TRIPLET_AVR = avr
TRIPLET_TARGET_AVR = $(TRIPLET_AVR)
TRIPLET_HOST_AMD64_WINDOWS = $(TRIPLET_AMD64_WINDOWS)
CC_BUILD_NATIVE = $(CC)
CC_HOST_AMD64_WINDOWS = $(TRIPLET_HOST_AMD64_WINDOWS)-gcc

# Set to `true` if AVR GNU Binutils and AVR GCC of sufficient version are already installed
WITH_PREINSTALLED = false

PREFIX_BASE = $(strip $(dir $(realpath $(firstword $(MAKEFILE_LIST)))))
PREFIX_DOWNLOAD = download
PREFIX_BUILD = build

BUNDLE_DIR_NATIVE = $(PREFIX_BASE)AVR-GNU-Toolchain-$(VERSION_TOOLCHAIN)
BUNDLE_DIR_AMD64_WINDOWS = $(PREFIX_BASE)AVR-GNU-Toolchain-$(VERSION_TOOLCHAIN)-AMD64-Windows

SOURCE_URL_BINUTILS = https://ftp.gnu.org/gnu/binutils/binutils-$(VERSION_BINUTILS).tar.xz
SOURCE_ARCHIVE_BINUTILS = $(PREFIX_DOWNLOAD)/binutils-$(VERSION_BINUTILS).tar.xz
SOURCE_DIR_BINUTILS = $(PREFIX_BUILD)/binutils-$(VERSION_BINUTILS)
BUILD_DIR_AVR_BINUTILS_NATIVE = $(SOURCE_DIR_BINUTILS)/build
INSTALL_DIR_AVR_BINUTILS_NATIVE = AVR-Binutils-$(VERSION_BINUTILS)
PREFIX_AVR_BINUTILS_NATIVE = $(PREFIX_BASE)$(INSTALL_DIR_AVR_BINUTILS_NATIVE)
BUNDLE_TARGET_AVR_BINUTILS_NATIVE = $(BUNDLE_DIR_NATIVE)/bin/avr-as
BUILD_DIR_AVR_BINUTILS_AMD64_WINDOWS = $(SOURCE_DIR_BINUTILS)/build-amd64-windows
INSTALL_DIR_AVR_BINUTILS_AMD64_WINDOWS = AVR-Binutils-$(VERSION_BINUTILS)-AMD64-Windows
PREFIX_AVR_BINUTILS_AMD64_WINDOWS = $(PREFIX_BASE)$(INSTALL_DIR_AVR_BINUTILS_AMD64_WINDOWS)
BUNDLE_TARGET_AVR_BINUTILS_AMD64_WINDOWS = $(BUNDLE_DIR_AMD64_WINDOWS)/bin/avr-as.exe

SOURCE_URL_GDB = https://ftp.gnu.org/gnu/gdb/gdb-$(VERSION_GDB).tar.xz
SOURCE_ARCHIVE_GDB = $(PREFIX_DOWNLOAD)/gdb-$(VERSION_GDB).tar.xz
SOURCE_DIR_GDB = $(PREFIX_BUILD)/gdb-$(VERSION_GDB)
BUILD_DIR_AVR_GDB_NATIVE = $(SOURCE_DIR_GDB)/build
INSTALL_DIR_AVR_GDB_NATIVE = AVR-GDB-$(VERSION_GDB)
PREFIX_AVR_GDB_NATIVE = $(PREFIX_BASE)$(INSTALL_DIR_AVR_GDB_NATIVE)
BUNDLE_TARGET_AVR_GDB_NATIVE = $(BUNDLE_DIR_NATIVE)/bin/avr-gdb
BUILD_DIR_AVR_GDB_AMD64_WINDOWS = $(SOURCE_DIR_GDB)/build-amd64-windows
INSTALL_DIR_AVR_GDB_AMD64_WINDOWS = AVR-GDB-$(VERSION_GDB)-AMD64-Windows
PREFIX_AVR_GDB_AMD64_WINDOWS = $(PREFIX_BASE)$(INSTALL_DIR_AVR_GDB_AMD64_WINDOWS)
BUNDLE_TARGET_AVR_GDB_AMD64_WINDOWS = $(BUNDLE_DIR_AMD64_WINDOWS)/bin/avr-gdb.exe

CONFIGURE_GMP_OPTIONS = \
--disable-shared\
--enable-static
SOURCE_URL_GMP = https://ftp.gnu.org/gnu/gmp/gmp-$(VERSION_GMP).tar.xz
SOURCE_ARCHIVE_GMP = $(PREFIX_DOWNLOAD)/gmp-$(VERSION_GMP).tar.xz
BUILD_DIR_GMP_AMD64_WINDOWS = $(PREFIX_BUILD)/gmp-$(VERSION_GMP)-amd64-windows
INSTALL_DIR_GMP_AMD64_WINDOWS = GMP-$(VERSION_GMP)-AMD64-Windows
PREFIX_GMP_AMD64_WINDOWS = $(PREFIX_BASE)$(INSTALL_DIR_GMP_AMD64_WINDOWS)

CONFIGURE_XZ_OPTIONS = \
--disable-shared\
--enable-static\
--disable-xz\
--disable-xzdec\
--disable-lzmadec\
--disable-lzmainfo\
--disable-lzma-links\
--disable-scripts\
--disable-doc\
--enable-threads
SOURCE_URL_XZ = https://tukaani.org/xz/xz-$(VERSION_XZ).tar.xz
SOURCE_ARCHIVE_XZ = $(PREFIX_DOWNLOAD)/xz-$(VERSION_XZ).tar.xz
BUILD_DIR_LZMA_AMD64_WINDOWS = $(PREFIX_BUILD)/lzma-$(VERSION_XZ)-amd64-windows
INSTALL_DIR_LZMA_AMD64_WINDOWS = LZMA-$(VERSION_XZ)-AMD64-Windows
PREFIX_LZMA_AMD64_WINDOWS = $(PREFIX_BASE)$(INSTALL_DIR_LZMA_AMD64_WINDOWS)

SOURCE_URL_XXHASH = https://github.com/Cyan4973/xxHash/archive/refs/tags/v$(VERSION_XXHASH).tar.gz
SOURCE_ARCHIVE_XXHASH = $(PREFIX_DOWNLOAD)/xxhash-$(VERSION_XXHASH).tar.gz
BUILD_DIR_XXHASH_AMD64_WINDOWS = $(PREFIX_BUILD)/xxhash-$(VERSION_XXHASH)-amd64-windows
INSTALL_DIR_XXHASH_AMD64_WINDOWS = xxHash-$(VERSION_XXHASH)-AMD64-Windows
PREFIX_XXHASH_AMD64_WINDOWS = $(PREFIX_BASE)$(INSTALL_DIR_XXHASH_AMD64_WINDOWS)

SOURCE_URL_GCC = https://ftp.gnu.org/gnu/gcc/gcc-$(VERSION_GCC)/gcc-$(VERSION_GCC).tar.xz
SOURCE_ARCHIVE_GCC = $(PREFIX_DOWNLOAD)/gcc-$(VERSION_GCC).tar.xz
SOURCE_DIR_NAME_GCC = gcc-$(VERSION_GCC)
SOURCE_DIR_GCC = $(PREFIX_BUILD)/$(SOURCE_DIR_NAME_GCC)
BUILD_DIR_AVR_GCC_NATIVE = $(PREFIX_BUILD)/$(SOURCE_DIR_NAME_GCC)-build
INSTALL_DIR_AVR_GCC_NATIVE = AVR-GCC-$(VERSION_GCC)
PREFIX_AVR_GCC_NATIVE = $(PREFIX_BASE)$(INSTALL_DIR_AVR_GCC_NATIVE)
BUNDLE_TARGET_AVR_GCC_NATIVE = $(BUNDLE_DIR_NATIVE)/bin/avr-gcc
BUILD_DIR_AVR_GCC_AMD64_WINDOWS = $(PREFIX_BUILD)/$(SOURCE_DIR_NAME_GCC)-build-amd64-windows
INSTALL_DIR_AVR_GCC_AMD64_WINDOWS = AVR-GCC-$(VERSION_GCC)-AMD64-Windows
PREFIX_AVR_GCC_AMD64_WINDOWS = $(PREFIX_BASE)$(INSTALL_DIR_AVR_GCC_AMD64_WINDOWS)
BUNDLE_TARGET_AVR_GCC_AMD64_WINDOWS = $(BUNDLE_DIR_AMD64_WINDOWS)/bin/avr-gcc.exe

SOURCE_URL_AVR_LIBC = https://download.savannah.gnu.org/releases/avr-libc/avr-libc-$(VERSION_AVR_LIBC).tar.bz2
SOURCE_ARCHIVE_AVR_LIBC = $(PREFIX_DOWNLOAD)/avr-libc-$(VERSION_AVR_LIBC).tar.bz2
BUILD_DIR_AVR_LIBC = $(PREFIX_BUILD)/avr-libc-$(VERSION_AVR_LIBC)
INSTALL_DIR_AVR_LIBC = AVR-LibC-$(VERSION_AVR_LIBC)
PREFIX_AVR_LIBC = $(PREFIX_BASE)$(INSTALL_DIR_AVR_LIBC)
BUNDLE_TARGET_AVR_LIBC_NATIVE = $(BUNDLE_DIR_NATIVE)/avr/include/avr/io.h
BUNDLE_TARGET_AVR_LIBC_AMD64_WINDOWS = $(BUNDLE_DIR_AMD64_WINDOWS)/avr/include/avr/io.h

# Default target
.PHONY: all all-native all-amd64-windows
all: all-native all-amd64-windows
all-native: $(BUNDLE_TARGET_AVR_BINUTILS_NATIVE) $(BUNDLE_TARGET_AVR_GDB_NATIVE) $(BUNDLE_TARGET_AVR_GCC_NATIVE) $(BUNDLE_TARGET_AVR_LIBC_NATIVE)
all-amd64-windows: $(BUNDLE_TARGET_AVR_BINUTILS_AMD64_WINDOWS) $(BUNDLE_TARGET_AVR_GDB_AMD64_WINDOWS) $(BUNDLE_TARGET_AVR_GCC_AMD64_WINDOWS) $(BUNDLE_TARGET_AVR_LIBC_AMD64_WINDOWS)

# AVR GNU Binutils
.PHONY: avr-binutils-native avr-binutils-amd64-windows bundle-avr-binutils-native bundle-avr-binutils-amd64-windows
avr-binutils-native: $(INSTALL_DIR_AVR_BINUTILS_NATIVE)
avr-binutils-amd64-windows: $(INSTALL_DIR_AVR_BINUTILS_AMD64_WINDOWS)
bundle-avr-binutils-native: $(BUNDLE_TARGET_AVR_BINUTILS_NATIVE)
bundle-avr-binutils-amd64-windows: $(BUNDLE_TARGET_AVR_BINUTILS_AMD64_WINDOWS)

$(SOURCE_ARCHIVE_BINUTILS):
	mkdir -p $(PREFIX_DOWNLOAD)
	wget $(SOURCE_URL_BINUTILS) -O $@

$(SOURCE_DIR_BINUTILS): $(SOURCE_ARCHIVE_BINUTILS)
	mkdir -p $@
	tar -xf $< -C $@ --strip-components=1

$(BUILD_DIR_AVR_BINUTILS_NATIVE): $(SOURCE_DIR_BINUTILS)
	mkdir -p $@
	cd $@ && ../configure --prefix=$(PREFIX_AVR_BINUTILS_NATIVE) --target=$(TRIPLET_TARGET_AVR) $(CONFIGURE_BINUTILS_OPTIONS)
	$(MAKE) -C $@

$(INSTALL_DIR_AVR_BINUTILS_NATIVE): $(BUILD_DIR_AVR_BINUTILS_NATIVE)
	$(MAKE) -C $< install-strip

$(BUNDLE_TARGET_AVR_BINUTILS_NATIVE): $(INSTALL_DIR_AVR_BINUTILS_NATIVE)
	mkdir -p $(BUNDLE_DIR_NATIVE)
	cp -r $(INSTALL_DIR_AVR_BINUTILS_NATIVE)/* $(BUNDLE_DIR_NATIVE)/

$(BUILD_DIR_AVR_BINUTILS_AMD64_WINDOWS): $(SOURCE_DIR_BINUTILS)
	mkdir -p $@
	cd $@ && ../configure --prefix=$(PREFIX_AVR_BINUTILS_AMD64_WINDOWS) --target=$(TRIPLET_TARGET_AVR) --host=$(TRIPLET_HOST_AMD64_WINDOWS) $(CONFIGURE_BINUTILS_OPTIONS)
	$(MAKE) -C $@

$(INSTALL_DIR_AVR_BINUTILS_AMD64_WINDOWS): $(BUILD_DIR_AVR_BINUTILS_AMD64_WINDOWS)
	$(MAKE) -C $< install-strip

$(BUNDLE_TARGET_AVR_BINUTILS_AMD64_WINDOWS): $(INSTALL_DIR_AVR_BINUTILS_AMD64_WINDOWS)
	mkdir -p $(BUNDLE_DIR_AMD64_WINDOWS)
	cp -r $(INSTALL_DIR_AVR_BINUTILS_AMD64_WINDOWS)/* $(BUNDLE_DIR_AMD64_WINDOWS)/

# AVR GDB
.PHONY: avr-gdb-native avr-gdb-amd64-windows bundle-avr-gdb-native bundle-avr-gdb-amd64-windows
avr-gdb-native: $(INSTALL_DIR_AVR_GDB_NATIVE)
avr-gdb-amd64-windows: $(INSTALL_DIR_AVR_GDB_AMD64_WINDOWS)
bundle-avr-gdb-native: $(BUNDLE_TARGET_AVR_GDB_NATIVE)
bundle-avr-gdb-amd64-windows: $(BUNDLE_TARGET_AVR_GDB_AMD64_WINDOWS)

$(SOURCE_ARCHIVE_GDB):
	mkdir -p $(PREFIX_DOWNLOAD)
	wget $(SOURCE_URL_GDB) -O $@

$(SOURCE_DIR_GDB): $(SOURCE_ARCHIVE_GDB)
	mkdir -p $@
	tar -xf $< -C $@ --strip-components=1

$(BUILD_DIR_AVR_GDB_NATIVE): $(SOURCE_DIR_GDB)
	mkdir -p $@
	cd $@ && ../configure --prefix=$(PREFIX_AVR_GDB_NATIVE) --target=$(TRIPLET_TARGET_AVR) $(CONFIGURE_GDB_OPTIONS)
	$(MAKE) -C $@

$(INSTALL_DIR_AVR_GDB_NATIVE): $(BUILD_DIR_AVR_GDB_NATIVE)
	$(MAKE) -C $< install-strip

$(BUNDLE_TARGET_AVR_GDB_NATIVE): $(INSTALL_DIR_AVR_GDB_NATIVE)
	mkdir -p $(BUNDLE_DIR_NATIVE)
	cp -r $(INSTALL_DIR_AVR_GDB_NATIVE)/* $(BUNDLE_DIR_NATIVE)/

$(BUILD_DIR_AVR_GDB_AMD64_WINDOWS): $(SOURCE_DIR_GDB) $(INSTALL_DIR_GMP_AMD64_WINDOWS) $(INSTALL_DIR_LZMA_AMD64_WINDOWS) $(INSTALL_DIR_XXHASH_AMD64_WINDOWS)
	mkdir -p $@
	cd $@ && ../configure --prefix=$(PREFIX_AVR_GDB_AMD64_WINDOWS) --target=$(TRIPLET_TARGET_AVR) --host=$(TRIPLET_HOST_AMD64_WINDOWS) $(CONFIGURE_GDB_OPTIONS) \
		--with-libgmp-prefix=$(PREFIX_GMP_AMD64_WINDOWS)\
		--with-liblzma-prefix=$(PREFIX_LZMA_AMD64_WINDOWS)\
		--with-libxxhash-prefix=$(PREFIX_XXHASH_AMD64_WINDOWS)
	$(MAKE) -C $@

$(INSTALL_DIR_AVR_GDB_AMD64_WINDOWS): $(BUILD_DIR_AVR_GDB_AMD64_WINDOWS)
	$(MAKE) -C $< install-strip

$(BUNDLE_TARGET_AVR_GDB_AMD64_WINDOWS): $(INSTALL_DIR_AVR_GDB_AMD64_WINDOWS)
	mkdir -p $(BUNDLE_DIR_AMD64_WINDOWS)
	cp -r $(INSTALL_DIR_AVR_GDB_AMD64_WINDOWS)/* $(BUNDLE_DIR_AMD64_WINDOWS)/

# GMP for AMD64-Windows (Used by GDB for AMD64-Windows)
$(SOURCE_ARCHIVE_GMP):
	mkdir -p $(PREFIX_DOWNLOAD)
	wget $(SOURCE_URL_GMP) -O $@

$(BUILD_DIR_GMP_AMD64_WINDOWS): export CC_FOR_BUILD = $(CC_BUILD_NATIVE)
$(BUILD_DIR_GMP_AMD64_WINDOWS): $(SOURCE_ARCHIVE_GMP)
	mkdir -p $@
	tar -xf $< -C $@ --strip-components=1
	cd $@ && ./configure --prefix=$(PREFIX_GMP_AMD64_WINDOWS) --host=$(TRIPLET_HOST_AMD64_WINDOWS) $(CONFIGURE_GMP_OPTIONS)
	$(MAKE) -C $@
	$(MAKE) -C $@ check

$(INSTALL_DIR_GMP_AMD64_WINDOWS): $(BUILD_DIR_GMP_AMD64_WINDOWS)
	$(MAKE) -C $< install-strip

# LZMA for AMD64-Windows (Used by GDB for AMD64-Windows)
$(SOURCE_ARCHIVE_XZ):
	mkdir -p $(PREFIX_DOWNLOAD)
	wget $(SOURCE_URL_XZ) -O $@

$(BUILD_DIR_LZMA_AMD64_WINDOWS): $(SOURCE_ARCHIVE_XZ)
	mkdir -p $@
	tar -xf $< -C $@ --strip-components=1
	cd $@ && ./configure --prefix=$(PREFIX_LZMA_AMD64_WINDOWS) --host=$(TRIPLET_HOST_AMD64_WINDOWS) $(CONFIGURE_XZ_OPTIONS)
	$(MAKE) -C $@
	$(MAKE) -C $@ check

$(INSTALL_DIR_LZMA_AMD64_WINDOWS): $(BUILD_DIR_LZMA_AMD64_WINDOWS)
	$(MAKE) -C $< install-strip

# xxHash for AMD64-Windows (Used by GDB for AMD64-Windows)
$(SOURCE_ARCHIVE_XXHASH):
	mkdir -p $(PREFIX_DOWNLOAD)
	wget $(SOURCE_URL_XXHASH) -O $@

$(BUILD_DIR_XXHASH_AMD64_WINDOWS): export CC = $(CC_HOST_AMD64_WINDOWS)
$(BUILD_DIR_XXHASH_AMD64_WINDOWS): $(SOURCE_ARCHIVE_XXHASH)
	mkdir -p $@
	tar -xf $< -C $@ --strip-components=1
	$(MAKE) -C $@ libxxhash.a

$(INSTALL_DIR_XXHASH_AMD64_WINDOWS): $(BUILD_DIR_XXHASH_AMD64_WINDOWS)
	mkdir -p $(PREFIX_XXHASH_AMD64_WINDOWS)/lib
	cp $</libxxhash.a $(PREFIX_XXHASH_AMD64_WINDOWS)/lib/
	mkdir -p $(PREFIX_XXHASH_AMD64_WINDOWS)/include
	cp $</xxh3.h $(PREFIX_XXHASH_AMD64_WINDOWS)/include/
	cp $</xxhash.h $(PREFIX_XXHASH_AMD64_WINDOWS)/include/

# AVR GCC
.PHONY: avr-gcc-native avr-gcc-amd64-windows bundle-avr-gcc-native bundle-avr-gcc-amd64-windows
avr-gcc-native: $(INSTALL_DIR_AVR_GCC_NATIVE)
avr-gcc-amd64-windows: $(INSTALL_DIR_AVR_GCC_AMD64_WINDOWS)
bundle-avr-gcc-native: $(BUNDLE_TARGET_AVR_GCC_NATIVE)
bundle-avr-gcc-amd64-windows: $(BUNDLE_TARGET_AVR_GCC_AMD64_WINDOWS)

$(SOURCE_ARCHIVE_GCC):
	mkdir -p $(PREFIX_DOWNLOAD)
	wget $(SOURCE_URL_GCC) -O $@

$(SOURCE_DIR_GCC): $(SOURCE_ARCHIVE_GCC)
	mkdir -p $@
	tar -xf $< -C $@ --strip-components=1
	cd $@ && ./contrib/download_prerequisites

ifneq ($(WITH_PREINSTALLED), true) # If AVR toolchain is not preinstalled
$(BUILD_DIR_AVR_GCC_NATIVE): export PATH := $(PATH):$(BUNDLE_DIR_NATIVE)/bin
$(BUILD_DIR_AVR_GCC_NATIVE): $(BUNDLE_TARGET_AVR_BINUTILS_NATIVE)
endif
$(BUILD_DIR_AVR_GCC_NATIVE): $(SOURCE_DIR_GCC)
	mkdir -p $@
	cd $@ && ../$(SOURCE_DIR_NAME_GCC)/configure --prefix=$(PREFIX_AVR_GCC_NATIVE) --target=$(TRIPLET_TARGET_AVR) $(CONFIGURE_GCC_OPTIONS)
	$(MAKE) -C $@

ifneq ($(WITH_PREINSTALLED), true) # If AVR toolchain is not preinstalled
$(INSTALL_DIR_AVR_GCC_NATIVE): export PATH := $(PATH):$(BUNDLE_DIR_NATIVE)/bin
endif
$(INSTALL_DIR_AVR_GCC_NATIVE): $(BUILD_DIR_AVR_GCC_NATIVE)
	$(MAKE) -C $< install-strip

$(BUNDLE_TARGET_AVR_GCC_NATIVE): $(INSTALL_DIR_AVR_GCC_NATIVE)
	mkdir -p $(BUNDLE_DIR_NATIVE)
	cp -r $(INSTALL_DIR_AVR_GCC_NATIVE)/* $(BUNDLE_DIR_NATIVE)/

ifneq ($(WITH_PREINSTALLED), true) # If AVR toolchain is not preinstalled
$(BUILD_DIR_AVR_GCC_AMD64_WINDOWS): export PATH := $(PATH):$(BUNDLE_DIR_NATIVE)/bin
$(BUILD_DIR_AVR_GCC_AMD64_WINDOWS): $(BUNDLE_TARGET_AVR_BINUTILS_NATIVE) $(BUNDLE_TARGET_AVR_GCC_NATIVE)
endif
$(BUILD_DIR_AVR_GCC_AMD64_WINDOWS): $(SOURCE_DIR_GCC)
	mkdir -p $@
	cd $@ && ../$(SOURCE_DIR_NAME_GCC)/configure --prefix=$(PREFIX_AVR_GCC_AMD64_WINDOWS) --target=$(TRIPLET_TARGET_AVR) --host=$(TRIPLET_HOST_AMD64_WINDOWS) $(CONFIGURE_GCC_OPTIONS)
	$(MAKE) -C $@

ifneq ($(WITH_PREINSTALLED), true) # If AVR toolchain is not preinstalled
$(INSTALL_DIR_AVR_GCC_AMD64_WINDOWS): export PATH := $(PATH):$(BUNDLE_DIR_NATIVE)/bin
endif
$(INSTALL_DIR_AVR_GCC_AMD64_WINDOWS): $(BUILD_DIR_AVR_GCC_AMD64_WINDOWS)
	$(MAKE) -C $< install-strip

$(BUNDLE_TARGET_AVR_GCC_AMD64_WINDOWS): $(INSTALL_DIR_AVR_GCC_AMD64_WINDOWS)
	mkdir -p $(BUNDLE_DIR_AMD64_WINDOWS)
	cp -r $(INSTALL_DIR_AVR_GCC_AMD64_WINDOWS)/* $(BUNDLE_DIR_AMD64_WINDOWS)/

# AVR LibC
.PHONY: avr-libc bundle-avr-libc-native bundle-avr-libc-amd64-windows
avr-libc: $(INSTALL_DIR_AVR_LIBC)
bundle-avr-libc-native: $(BUNDLE_TARGET_AVR_LIBC_NATIVE)
bundle-avr-libc-amd64-windows: $(BUNDLE_TARGET_AVR_LIBC_AMD64_WINDOWS)

$(SOURCE_ARCHIVE_AVR_LIBC):
	mkdir -p $(PREFIX_DOWNLOAD)
	wget $(SOURCE_URL_AVR_LIBC) -O $@

ifneq ($(WITH_PREINSTALLED), true) # If AVR toolchain is not preinstalled
$(BUILD_DIR_AVR_LIBC): export PATH := $(PATH):$(BUNDLE_DIR_NATIVE)/bin
$(BUILD_DIR_AVR_LIBC): $(BUNDLE_TARGET_AVR_BINUTILS_NATIVE) $(BUNDLE_TARGET_AVR_GCC_NATIVE)
endif
$(BUILD_DIR_AVR_LIBC): $(SOURCE_ARCHIVE_AVR_LIBC)
	mkdir -p $@
	tar -xf $< -C $@ --strip-components=1
	cd $@ && ./configure --prefix=$(PREFIX_AVR_LIBC) --host=$(TRIPLET_TARGET_AVR) $(CONFIGURE_AVR_LIBC_OPTIONS)
	$(MAKE) -C $@

ifneq ($(WITH_PREINSTALLED), true) # If AVR toolchain is not preinstalled
$(INSTALL_DIR_AVR_LIBC): export PATH := $(PATH):$(BUNDLE_DIR_NATIVE)/bin
endif
$(INSTALL_DIR_AVR_LIBC): $(BUILD_DIR_AVR_LIBC)
	$(MAKE) -C $< install-strip

$(BUNDLE_TARGET_AVR_LIBC_NATIVE): $(INSTALL_DIR_AVR_LIBC)
	mkdir -p $(BUNDLE_DIR_NATIVE)
	cp -r $(INSTALL_DIR_AVR_LIBC)/* $(BUNDLE_DIR_NATIVE)/

$(BUNDLE_TARGET_AVR_LIBC_AMD64_WINDOWS): $(INSTALL_DIR_AVR_LIBC)
	mkdir -p $(BUNDLE_DIR_AMD64_WINDOWS)
	cp -r $(INSTALL_DIR_AVR_LIBC)/* $(BUNDLE_DIR_AMD64_WINDOWS)/

# Misc. commands
.PHONY: clean
clean: clean-bundle clean-install clean-build clean-download

.PHONY:
clean-bundle:
	-rm -rf $(BUNDLE_DIR_NATIVE)
	-rm -rf $(BUNDLE_DIR_AMD64_WINDOWS)

.PHONY: clean-install
clean-install:
	-rm -rf $(INSTALL_DIR_AVR_BINUTILS_NATIVE)
	-rm -rf $(INSTALL_DIR_AVR_BINUTILS_AMD64_WINDOWS)
	-rm -rf $(INSTALL_DIR_AVR_GDB_NATIVE)
	-rm -rf $(INSTALL_DIR_AVR_GDB_AMD64_WINDOWS)
	-rm -rf $(INSTALL_DIR_GMP_AMD64_WINDOWS)
	-rm -rf $(INSTALL_DIR_LZMA_AMD64_WINDOWS)
	-rm -rf $(INSTALL_DIR_XXHASH_AMD64_WINDOWS)
	-rm -rf $(INSTALL_DIR_AVR_GCC_NATIVE)
	-rm -rf $(INSTALL_DIR_AVR_GCC_AMD64_WINDOWS)
	-rm -rf $(INSTALL_DIR_AVR_LIBC)

.PHONY: clean-build
clean-build:
	-rm -rf $(PREFIX_BUILD)

.PHONY: clean-download
clean-download:
	-rm -rf $(PREFIX_DOWNLOAD)
