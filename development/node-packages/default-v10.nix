{ pkgs, nodejs, stdenv }:

import ./composition-v10.nix {
  inherit pkgs nodejs;
  inherit (stdenv.hostPlatform) system;
}
