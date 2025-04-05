{ pkgs ? import <nixpkgs> {} }:

let
  # OS cross-compilation: our toolchain for x86_64-elf
  x86Pkgs = import <nixpkgs> {
    crossSystem = {
      config = "x86_64-elf";
      libc = "newlib";
      isStatic = true;
      useLLVM = false;
    };
  };

  # GRUB cross-compilation: target a 32-bit (i386-pc) environment.
  grubPkgs = import <nixpkgs> {
    crossSystem = {
      config = "i686-linux";
    };
  };
in pkgs.mkShell {
  buildInputs = [
    # OS cross-compilation tools
    x86Pkgs.buildPackages.gcc
    x86Pkgs.buildPackages.binutils
    # Basic development tools
    pkgs.gnumake
    pkgs.nasm
    pkgs.qemu
    pkgs.xorriso
    # GRUB build for i386-pc bootloader
    grubPkgs.grub2
  ];

  shellHook = ''
    # Add OS cross-compilers to PATH
    export PATH="${x86Pkgs.buildPackages.gcc}/bin:${x86Pkgs.buildPackages.binutils}/bin:$PATH"
    echo "x86 GCC Cross-compiler environment loaded!"
    echo "Compiler version: $(x86_64-elf-gcc --version | head -n 1)"
    # Set GRUB_DIR to the GRUB installation containing i386-pc modules
    export GRUB_DIR="${grubPkgs.grub2}/lib/grub"
    echo "GRUB cross-compilation environment loaded from: $GRUB_DIR"
  '';
}
