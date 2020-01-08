{ pkgs }:

with pkgs;
rec {
  argparse = python3Packages.callPackage ./argparse.nix {};
  aws-amicleaner = callPackage ./aws-amicleaner.nix { inherit argparse awscli; };
}
