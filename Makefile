# Makefile for compiling, linking, and building the program.
# Begin Variables Section

## Program Section: change these variables based on your program
# The name of the program to build.
TARGET := targetname

## Compiler Section: change these variables based on your compiler
# -----------------------------------------------------------------------------
# The compiler executable.
CC := gcc
# The compiler flags.
CFLAGS := -Wall -Werror -Wpedantic -std=gnu99
# The linker executable.
LD := gcc
# The linker flags.
LDFLAGS := -Wall -Werror -Wpedantic -std=gnu99
# The shell executable.
SHELL := /bin/bash

## Testing Suite Section: change these variables based on your testing suite
# -----------------------------------------------------------------------------
# The memory checker executable.
MEMCHECK := valgrind
# The memory checker flags.
MEMCHECK_FLAGS := --leak-check=full --show-leak-kinds=all --track-origins=yes
# The debugger executable.
DEBUGGER := gdb
# The debugger flags.
DEBUGGER_FLAGS :=

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
BUILD_DIR := $(TOP_DIR)/target/release/

# header files to preprocess
INCS := -I$(INC_DIR)
# source files to compile
SRCS := $(wildcard $(SRC_DIR)/*.c)
# object files to link
OBJS := $(patsubst $(SRC_DIR)/%.c, $(OBJ_DIR)/%.o, $(SRCS))
# name of executable file to build
BINS := $(BUILD_DIR)$(TARGET)
# name of binary file to build
TARGET_BIN := $(BINS).bin

## Command Section: change these variables based on your commands
# -----------------------------------------------------------------------------
# Targets
.PHONY: all $(TARGET) dirs test clean debug help

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

# Test target: build and test the program against sample input
test: $(TARGET)
	$(TARGET_BIN) -c -f $(TEST_OUTPUT) $(TEST_INPUT)

# @echo "Testing $(BINS)..."
# @echo "Testing memory leaks..."
# $(MEMCHECK) $(MEMCHECK_FLAGS) $(BINS)
# @echo "Comparing output to $(REF_EXE):"
# diff <($(BINS)) <($(REF_EXE))

# Directory target: create the build and object directories
dirs:
	@mkdir -p $(BUILD_DIR)
	@mkdir -p $(OBJ_DIR)

# Clean target: remove build artifacts and non-essential files
clean:
	rm -rf $(OBJ_DIR) $(BIN_DIR)
	rm -rf $(BUILD_DIR)

# Debug target: use a debugger to debug the program
debug: $(TARGET_BIN)
	@echo "Debugging $(TARGET)..."
	$(DEBUGGER) $(DEBUGGER_FLAGS) $(TARGET_BIN)

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
