#########################################################################
#
#                 -- Generated with omgcmd --
#      (do not edit unless you know what you're doing)
#
#########################################################################

{ pkgs ? import ./default.nix { } }:
with pkgs;
mkShell {
  buildInputs = [
    bash
    cacert
    consul
    curl
    direnv
    dos2unix
    git
    github-cli
    gnumake
    go
    haskellPackages.ShellCheck
    jq
    nix-prefetch-git
    nixfmt
    openssh
    packer
    (python3.withPackages (ps: [ ps.autopep8 ]))
    shfmt
    terraform_1
    vault
    which
    wget
  ];
}
