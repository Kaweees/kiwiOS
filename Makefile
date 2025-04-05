# Makefile for compiling, linking, and building the program.
# Begin Variables Section

## Program Section: change these variables based on your program
# The name of the program to build.
TARGET := kiwios

## Bootloader Section: change these variables based on your bootloader
# -----------------------------------------------------------------------------
# The bootloader executable.
BOOTLOADER := bootloader
# The bootloader flags.
BOOTLOADER_FLAGS :=

## Architecture Section: change these variables based on your architecture
# -----------------------------------------------------------------------------
# The architecture to build for.
ARCH := x86_64
# The toolchain path
# TOOLCHAIN_PATH=/usr/bin/
# The toolchain prefix
TOOLCHAIN_PREFIX := x86_64-elf
# The architecture flags.
ARCH_FLAGS :=

## Compiler Section: change these variables based on your compiler
# -----------------------------------------------------------------------------
# The compiler executable.
CC := $(TOOLCHAIN_PATH)$(TOOLCHAIN_PREFIX)-gcc
# The compiler flags.
CFLAGS := -Wall -Werror -Wpedantic -std=gnu99
# The linker executable.
LD := $(TOOLCHAIN_PATH)$(TOOLCHAIN_PREFIX)-gcc
# The linker flags.
LDFLAGS := -Wall -Werror -Wpedantic -std=gnu99
# The shell executable.
SHELL := /bin/bash

# The name of the test input file
TEST_INPUT := test_input.txt
# The name of the test output file
TEST_OUTPUT := test_output.tar
# The name of the reference executable
REF_EXE := ~pn-cs357/demos/mytar
# The name of the reference output file
REF_OUTPUT := ref_output.tar

## Output Section: change these variables based on your output
# -----------------------------------------------------------------------------
# top directory of project
TOP_DIR := $(shell pwd)
# directory to locate source files
SRC_DIR := $(TOP_DIR)/src
# directory to locate header files
INC_DIR := $(TOP_DIR)/include
# directory to locate object files
OBJ_DIR := $(TOP_DIR)/obj
# directory to place build artifacts
BUILD_DIR := $(TOP_DIR)/target/$(ARCH)/release/

# header files to preprocess
INCS := -I$(INC_DIR)
# source files to compile
SRCS := $(wildcard $(SRC_DIR)/*.c)
# object files to link
OBJS := $(patsubst $(SRC_DIR)/%.c, $(OBJ_DIR)/%.o, $(SRCS))
#
BINS := $(BUILD_DIR)$(TARGET)
#
TARGET_ELF := $(BINS).elf
#
IMG_FILE := $(BUILD_DIR)$(TARGET).img

## QEMU Section: change these variables based on your QEMU
# -----------------------------------------------------------------------------
# The QEMU executable.
QEMU := qemu-system-$(ARCH)
# The QEMU flags.
QEMU_FLAGS := -drive format=raw,file=$(IMG_FILE)

## Command Section: change these variables based on your commands
# -----------------------------------------------------------------------------
# Targets
.PHONY: all $(TARGET) dirs clean kernel img run help

# Default target: build the program
all: $(BINS)

# Build the program
$(TARGET): $(BINS)

# Rule to build the target files
$(BINS): dirs $(TARGET_BIN)

# Rule to build the binary file from linked object files
$(TARGET_BIN): $(OBJS)
	$(LD) $(LDFLAGS) $(OBJS) -o $(TARGET_BIN)

# Rule to compile source files into object files
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	$(CC) $(CFLAGS) $(INCS) -c $< -o $@

# Directory target: create the build and object directories
dirs:
	@mkdir -p $(BUILD_DIR)
	@mkdir -p $(OBJ_DIR)

# Clean target: remove build artifacts and non-essential files
clean:
	@echo "Cleaning $(TARGET)..."
	rm -rf $(OBJ_DIR) $(BIN_DIR)
	rm -rf $(BUILD_DIR)

# Create a kernel image
kernel:
	$(CC) $(CFLAGS) $(INCS) -o $(TARGET_ELF) $(OBJS)

# Create an disk image
img:
	./scripts/image.sh $(IMG_FILE) $(TARGET_ELF)

# Run the disk image in QEMU
run: img
	$(QEMU) $(QEMU_FLAGS)

# Help target: display usage information
help:
	@echo "Usage: make <target>"
	@echo ""
	@echo "Targets:"
	@echo "  all              Build $(TARGET)"
	@echo "  $(TARGET)        Build $(TARGET)"
	@echo "  test             Build and test $(TARGET) against a sample input, use $(MEMCHECK) to check for memory leaks, and compare the output to $(REF_EXE)"
	@echo "  clean            Remove build artifacts and non-essential files"
	@echo "  debug            Use $(DEBUGGER) to debug $(TARGET)"
	@echo "  help             Display this help information"
