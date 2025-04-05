# Makefile for compiling, linking, and building the program.
# Begin Variables Section

## Architecture Section: change these variables based on your architecture
# -----------------------------------------------------------------------------
# The architecture to build for.
ARCH := x86_64
# The architecture flags.
ARCH_FLAGS :=

## Program Section: change these variables based on your program
# -----------------------------------------------------------------------------
# The name of the program to build.
TARGET := kiwios-$(ARCH)

# The toolchain path
# TOOLCHAIN_PATH := /usr/bin/
TOOLCHAIN_PATH :=
# The toolchain prefix
TOOLCHAIN_PREFIX := $(TOOLCHAIN_PATH)x86_64-elf

## Compiler Section: change these variables based on your compiler
# -----------------------------------------------------------------------------
# The compiler executable.
CC := $(TOOLCHAIN_PATH)$(TOOLCHAIN_PREFIX)-gcc
# The compiler flags.
CC_FLAGS := -Wall -Werror -Wpedantic -std=gnu99
# The assembler executable.
AS := nasm
# The assembler flags.
AS_FLAGS := -felf64
# The linker executable.
LD := $(TOOLCHAIN_PATH)$(TOOLCHAIN_PREFIX)-ld
# The linker flags.
LD_FLAGS := -n
# The shell executable.
SHELL := /bin/bash

## Output Section: change these variables based on your output
# -----------------------------------------------------------------------------
# top directory of project
TOP_DIR := $(shell pwd)
# directory to locate source files
SRC_DIR := $(TOP_DIR)/src
# directory to locate assembly files
ASM_DIR := $(SRC_DIR)/arch/$(ARCH)
# directory to locate linker file
LINKER_DIR := $(ASM_DIR)
# directory to locate header files
INC_DIR := $(TOP_DIR)/include
# directory to locate object files
OBJ_DIR := $(TOP_DIR)/obj
# directory to place build artifacts
BUILD_DIR := $(TOP_DIR)/target/$(ARCH)/release/

# header files to preprocess
INCS := -I$(INC_DIR)
# source files to compile
C_SRCS := $(wildcard $(SRC_DIR)/*.c)
# assembly files to compile
ASM_SRCS := $(wildcard $(ASM_DIR)/*.S) $(wildcard $(ASM_DIR)/*.s)
# linker file to link
LINKER_FILE := $(LINKER_DIR)/linker.ld
# object files to link
OBJS := $(patsubst $(SRC_DIR)/%.c, $(OBJ_DIR)/%.o, $(filter %.c,$(C_SRCS))) \
             $(patsubst $(ASM_DIR)/%.S, $(OBJ_DIR)/%.o, $(filter %.S,$(ASM_SRCS))) \
             $(patsubst $(ASM_DIR)/%.s, $(OBJ_DIR)/%.o, $(filter %.s,$(ASM_SRCS)))
BINS := $(BUILD_DIR)$(TARGET)
#
TARGET_ELF := $(BINS).elf
#
IMG_FILE := $(BINS).img

## QEMU Section: change these variables based on your QEMU
# -----------------------------------------------------------------------------
# The QEMU executable.
QEMU := qemu-system-$(ARCH)
# The QEMU flags.
QEMU_FLAGS := -drive format=raw,file=$(IMG_FILE)

## Debugger Section: change these variables based on your debugger
# -----------------------------------------------------------------------------
# The debugger executable.
DEBUGGER := gdb
# The debugger flags.
DEBUGGER_FLAGS := -ex "target remote :1234"

## Command Section: change these variables based on your commands
# -----------------------------------------------------------------------------
# Targets
.PHONY: all $(TARGET) kernel img emulate debug dirs clean help

# Default target: build the program
all: $(BINS)

# Build the program
$(TARGET): $(BINS)

# Rule to build the target files
$(BINS): dirs kernel img

# Rule to compile source files into object files
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c | $(OBJ_DIR)
	$(CC) $(CC_FLAGS) $(INCS) -c $< -o $@

$(OBJ_DIR)/%.o: $(ASM_DIR)/%.s | $(OBJ_DIR)
	$(AS) $(AS_FLAGS) -o $@ $<

$(OBJ_DIR)/%.o: $(ASM_DIR)/%.S | $(OBJ_DIR)
	$(AS) $(AS_FLAGS) -o $@ $<

# Kernel target: link object files into a kernel executable
kernel: $(OBJS)
	$(LD) $(LD_FLAGS) -T $(LINKER_FILE) -o $(TARGET_ELF) $(OBJS)

# Image target: create a disk image from the kernel executable
img: $(TARGET_ELF)
	sudo ./scripts/image.sh $(TARGET_ELF) $(IMG_FILE)

# Emulate target: run the disk image in QEMU
emulate: img
	$(QEMU) $(QEMU_FLAGS)

# Debug target: debug the program with GDB
debug:
	$(DEBUGGER) $(DEBUGGER_FLAGS) $(TARGET_ELF)

# Directory target: create the build and object directories
dirs:
	@mkdir -p $(BUILD_DIR)
	@mkdir -p $(OBJ_DIR)

# Clean target: remove build artifacts and non-essential files
clean:
	@echo "Cleaning $(TARGET)..."
	rm -rf $(OBJ_DIR) $(BIN_DIR)
	rm -rf $(BUILD_DIR)

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

# Ensure directory creation
$(OBJ_DIR):
	@mkdir -p $@

$(BUILD_DIR):
	@mkdir -p $@
