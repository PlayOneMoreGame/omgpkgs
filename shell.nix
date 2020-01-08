let
  # Look here for information about how to generate `nixpkgs-version.json`.
  #  → https://nixos.wiki/wiki/FAQ/Pinning_Nixpkgs
  pinnedVersions = builtins.fromJSON (builtins.readFile ./.nixpkgs-version.json);
  pinnedPkgs = import (builtins.fetchGit {
    inherit (pinnedVersions.nixpkgs) url rev;
    ref = "master";
  }) { config = { allowUnfree = true; };};
  omgPkgs = import ./default.nix { pkgs = pinnedPkgs; };
in

{ pkgs ? pinnedPkgs // omgPkgs }:
with pkgs;
mkShell {
  buildInputs = [
    direnv
    dos2unix
    git
    haskellPackages.ShellCheck
    nix-prefetch-git
    shfmt
  ];
}
