{ pkgs ? import <nixpkgs> {} }:

let
  # Create a custom nixpkgs with our cross system
  x86Pkgs = import <nixpkgs> {
    crossSystem = {
      config = "x86_64-elf";
      libc = "newlib";
      # Specify the exact x86 architecture features you need
      # This matches your Makefile TARGET_ARCH settings
      isStatic = true;
      useLLVM = false;
    };
  };
in pkgs.mkShell {
  name = "x86_64-elf-gcc-cross-compiler";

  # Include the cross compiler tools
  buildInputs = [
    # Cross compilers
    x86Pkgs.buildPackages.gcc
    x86Pkgs.buildPackages.binutils
    # Additional tools that might be helpful
    pkgs.gnumake
    pkgs.nasm # For assembly code
    pkgs.qemu # For testing your OS
    pkgs.xorriso # For creating bootable ISOs
  ];

  # Set up environment
  shellHook = ''
    # Export the compiler paths explicitly
    export PATH="${x86Pkgs.buildPackages.gcc}/bin:${x86Pkgs.buildPackages.binutils}/bin:$PATH"

    # Standard variables for cross compilation
    export TARGET=x86_64-elf
    export HOST=x86_64-elf
    export CC=x86_64-elf-gcc
    export CXX=x86_64-elf-g++
    export LD=x86_64-elf-ld
    export AS=x86_64-elf-as
    export AR=x86_64-elf-ar
    export RANLIB=x86_64-elf-ranlib
    export STRIP=x86_64-elf-strip
    export OBJCOPY=x86_64-elf-objcopy

    # Display compiler information
    echo "Cross compiler environment set up for x86_64-elf!"

    # Test for compiler availability
    if command -v x86_64-elf-gcc >/dev/null 2>&1; then
      echo "Compiler version: $(x86_64-elf-gcc --version | head -n1)"

      # Verify basic compilation works
      echo "int main() { return 0; }" > /tmp/test.c
      if x86_64-elf-gcc -ffreestanding -c /tmp/test.c -o /tmp/test.o 2>/dev/null; then
        echo "Compiler test: SUCCESS ✓"
        rm /tmp/test.c /tmp/test.o
      else
        echo "Compiler test: FAILED ✗"
      fi
    else
      echo "WARNING: x86_64-elf-gcc not found in PATH!"
      echo "Searching for available cross compilers..."
      echo ""
      echo "Available tools in crossPkgs.buildPackages.gcc:"
      find ${x86Pkgs.buildPackages.gcc}/bin -type f -executable | sort
      echo ""
      echo "Available tools in crossPkgs.buildPackages.binutils:"
      find ${x86Pkgs.buildPackages.binutils}/bin -type f -executable | sort
    fi

    # OS Development Help
    echo ""
    echo "OS Development Examples:"
    echo "  1. Create minimal kernel: echo 'void _start() { while(1); }' > kernel.c"
    echo "  2. Compile: x86_64-elf-gcc -ffreestanding -nostdlib -c kernel.c -o kernel.o"
    echo "  3. Link: x86_64-elf-ld -Ttext 0x1000 -o kernel.bin kernel.o"
  '';
}

