{ pkgs ? import <nixpkgs> {} }:

let
  # Create a custom nixpkgs with our cross system
  x86Pkgs = import <nixpkgs> {
    crossSystem = {
      config = "x86_64-elf";
      libc = "newlib";
      isStatic = true;
      useLLVM = false;
    };
  };
in pkgs.mkShell {
  # Include development tools
  buildInputs = [
    # Cross-compilation tools
    x86Pkgs.buildPackages.gcc
    x86Pkgs.buildPackages.binutils
    # Basic development tools
    pkgs.gnumake # Build system
    pkgs.nasm # For assembly code
    pkgs.qemu # For testing your OS
    pkgs.xorriso # For creating bootable ISOs
  ];

  # Set up environment variables to help with cross-compilation
  shellHook = ''
    # Export the compiler paths explicitly
    export PATH="${x86Pkgs.buildPackages.gcc}/bin:${x86Pkgs.buildPackages.binutils}/bin:$PATH"
    echo "x86 GCC Cross-compiler environment loaded!"
    echo "Compiler version: $(x86_64-elf-gcc --version | head -n 1)"
  '';
}

