{ flake-utils, nixpkgs, fenix, ... }:
{ pkgs, ... }: {
  # TODO can you derive 
  home.packages = [ fenix.packages."${pkgs.system}".latest.toolchain ];
}

