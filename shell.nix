{ pkgs ? import <nixpkgs> { } }:

let
  # Create a custom package set for cross-compilation to x86
  x86Pkgs = import <nixpkgs> {
    crossSystem = {
      config = "i686-elf";
      libc = "newlib";
      # Specify the exact x86 architecture features you need
      # This matches your Makefile TARGET_ARCH settings
      gcc = {
        arch = "i686";
        abi = "elf";
      };
    };
  };

  # Use overrideAttrs to directly modify the derivation attributes
  customX86Gcc = x86Pkgs.buildPackages.gcc.overrideAttrs (oldAttrs: {
    configureFlags = (oldAttrs.configureFlags or [ ])
      ++ [ "--enable-multilib" "--with-multilib-generator=i686-elf--" ];
  });
in pkgs.mkShell {
  # Include both the custom cross-compiler and other tools you might need
  buildInputs = [
    customX86Gcc
    # Additional tools that might be helpful
    pkgs.gnumake
    pkgs.nasm # For assembly code
    pkgs.qemu # For testing your OS
    pkgs.xorriso # For creating bootable ISOs
  ];

  # Set up environment variables to help with cross-compilation
  shellHook = ''
    export PATH=${customX86Gcc}/bin:$PATH
    echo "x86 GCC Cross-compiler environment loaded!"
    echo "Compiler version: $(i686-elf-gcc --version | head -n 1)"
  '';
}
