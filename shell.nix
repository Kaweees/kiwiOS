let
  nixpkgs = import <nixpkgs> { };
  cross = import <nixpkgs> {
    crossSystem = {
      # x86_64-embedded
      config = "x86_64-elf";
      libc = "newlib";
    };
  };
in nixpkgs.mkShell { buildInputs = [ cross.buildPackages.gcc ]; }
