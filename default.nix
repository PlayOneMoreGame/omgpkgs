let
  # Look here for information about how to generate `nixpkgs-version.json`.
  #  → https://nixos.wiki/wiki/FAQ/Pinning_Nixpkgs
  pinned-version = builtins.fromJSON (builtins.readFile ./.nixpkgs-version.json);
  pinned-nixpkgs = import (builtins.fetchGit {
    inherit (pinned-version.nixpkgs) url rev;
    ref = "nixos-unstable";
  }) {};
in

{ pkgs ? pinned-nixpkgs }:
with pkgs;
{
  nodePackages_10_x = recurseIntoAttrs (callPackage ./development/node-packages/default-v10.nix {
    nodejs = pkgs.nodejs-10_x;
  });
  nodePackages = nodePackages_10_x;
  # jw todo: include scss-lint-reporter-checkstyle to omgmacs
  omgmacs = callPackage ./applications/editors/omgmacs {};
  python3Packages = recurseIntoAttrs (
    python3Packages.callPackage ./development/python-packages {}
  );
  scss-lint-reporter-checkstyle = callPackage ./development/tools/scss-lint-reporter-checkstyle {};
  vault-openvpn = callPackage ./tools/security/vault-openvpn {};
  websocat = callPackage ./tools/networking/websocat {};
}
