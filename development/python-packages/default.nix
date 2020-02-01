{ pkgs }:

with pkgs;
rec {
  argparse = python3Packages.callPackage ./argparse.nix {};
}
