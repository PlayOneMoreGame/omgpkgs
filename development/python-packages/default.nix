{ pkgs ? import <nixpkgs> {} }:

with pkgs;
rec {
  argparse = python3Packages.callPackage ./argparse.nix {};
  awscli = callPackage ./awscli.nix {};
  aws-amicleaner = callPackage ./aws-amicleaner.nix { inherit argparse awscli; };
  # colorama-3 = python3Packages.callPackage ./colorama-3.nix {};
  # rsa = python3Packages.callPackage ./rsa.nix {};
}
