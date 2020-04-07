{ pkgs }:

with pkgs; rec {
  argparse = python3Packages.callPackage ./argparse.nix { };
  # JW TODO: Fix ami-cleaner package to not be part of the python3
  # installation and instead behave like awscli which is a standalone
  # application backed by Python.
  # aws-amicleaner = callPackage ./aws-amicleaner.nix { inherit argparse awscli; };
}
