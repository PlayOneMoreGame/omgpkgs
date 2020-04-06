# omgpkgs
[![Build status](https://badge.buildkite.com/f606c80f405a7f91393f5cc06e2b08ae7e021b418b234d3805.svg)](https://buildkite.com/one-more-game/omgpkgs)

A collection of public [Nix](https://nixos.org/nix/) package expressions and setup scripts for configuring a machine as a One More Game workstation.

## Setup

1. Follow the automated platform specific instructions found in the [OMG Computer Setup](https://github.com/PlayOneMoreGame/computer-setup) repository
1. Clone the repository

    ```
    $ git clone https://github.com/PlayOneMoreGame/omgpkgs.git
    $ cd omgpkgs
    ```

1. Follow the on-screen instructions to ready your shell and install all dependent software

## Developing

1. Familiarize yourself with the Nix packaging system. I'd recommend reading the following:
  * [Nix Pills](https://nixos.org/nixos/nix-pills/) - An excellent getting started guide for how Nix packaging works
  * [NixPkgs Manual](https://nixos.org/nixpkgs/manual/) - A reference manual for all things Nix packaging. The manual includes sections with instructions for how to build packages for languages and tools which have their own packaging systems (ie. Python, Ruby, or Emacs)

1. Modify what you'd like and then build the packages

   ```
   $ nix-build
   ```

   Or if you'd like to test a single package, run `nix-build` directly with the package attribute

   ```
   $ nix-build -A ${packageName}
   ```

1. Check the corresponding `result` symlink(s) for the package(s) you're testing. Each result symlink points to the derivation's contents in the Nix store.

## Testing

Built packages can be tested on the host machine since Nix packages are isolated, immutable, and atomic by nature. Simply build your package(s) and interact with the output in the corresponding result symlinks.

You'll need to manually install Vagrant and VMWare Fusion. After installation, run the following script:

    $ bin/test-setup

This will start a virtual machine for all supported platforms and distributions, run the setup script, test the virtual machine, and then destroy all of the virtual machines.

> The MIT license does not apply to the packages built by this repository, but of the package descriptions found inside this repository. This license may not apply to patches used to build software artifacts. All built packages are covered by their project's respective licenses.
