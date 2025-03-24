{ pkgs ? import <nixpkgs> { } }:

let
  # Create a custom package set for cross-compilation to RISC-V
  riscvPkgs = import <nixpkgs> {
    crossSystem = {
      config = "riscv32-none-elf";
      libc = "newlib";
      # Specify the exact RISC-V architecture features you need
      # This matches your Makefile TARGET_ARCH settings
      gcc = {
        arch = "rv32i";
        abi = "ilp32";
      };
    };
  };

  # Use overrideAttrs to directly modify the derivation attributes
  customRiscvGcc = riscvPkgs.buildPackages.gcc.overrideAttrs (oldAttrs: {
    configureFlags = (oldAttrs.configureFlags or [ ])
      ++ [ "--enable-multilib" "--with-multilib-generator=rv32i-ilp32--" ];
  });
in pkgs.mkShell {
  # Include both the custom cross-compiler and other tools you might need
  buildInputs = [
    customRiscvGcc
    # Additional tools that might be helpful
    pkgs.gnumake
  ];

  # Set up environment variables
  shellHook = ''
    export RISCV_PREFIX="riscv32-none-elf-"
    export PATH=${customRiscvGcc}/bin:$PATH
    echo "RISC-V GCC Cross-compiler environment loaded!"
    echo "Compiler version: $(riscv32-none-elf-gcc --version | head -n 1)"
  '';
}
