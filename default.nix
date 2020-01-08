{ pkgs ? import <nixpkgs> {} }:

with pkgs;
{
  dotnetCore = recurseIntoAttrs (callPackage ./development/compilers/dotnet { });
  nodePackages_10_x = recurseIntoAttrs (callPackage ./development/node-packages/default-v10.nix {
    nodejs = pkgs.nodejs-10_x;
  });
  nodePackages = nodePackages_10_x;
  python3Packages = recurseIntoAttrs (
    python3Packages.callPackage ./development/python-packages {}
  );
  scss-lint-reporter-checkstyle = callPackage ./development/tools/scss-lint-reporter-checkstyle {};
  vault-openvpn = callPackage ./tools/security/vault-openvpn {};
  websocat = callPackage ./tools/networking/websocat {};
}
