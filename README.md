# omgpkgs

A collection of [Nix](https://nixos.org/nix/) package expressions and setup scripts for configuring your machine as a One More Game workstation.

## Prerequisites

* Unix-like operating system (macOS, Linux, or [Windows Subsystem for Linux (WSL)](https://docs.microsoft.com/en-us/windows/wsl/install-win10))
* `curl`

## Usage

Until this repository is publicly hosted, you'll need to clone it and run the setup script from your filesystem directly:

1. Clone the repository
    ```
    $ git clone https://github.com/PlayOneMoreGame/omgpkgs.git
    $ cd omgpkgs
    ```

1. Run the setup script to prepare your host machine
   ```
   $ bin/setup.sh
   ```

In the future when this repository is opened to the public:

    ```
    $ curl -fsSL https://raw.githubusercontent.com/PlayOneMoreGame/omgpkgs/master/bin/setup.sh | bash
    ```

## Developing

1. Familiarize yourself with the Nix packaging system. I'd recommend reading the following:
  * [Nix Pills](https://nixos.org/nixos/nix-pills/) - An excellent getting started guide for how Nix packaging works
  * [NixPkgs Manual](https://nixos.org/nixpkgs/manual/) - A reference manual for all things Nix packaging. The manual includes sections with instructions for how to build packages for languages and tools which have their own packaging systems (ie. Python, Ruby, or Emacs)

1. Clone the repository
    ```
    $ git clone https://github.com/PlayOneMoreGame/omgpkgs.git
    $ cd omgpkgs
    ```

1. Run the setup script to prepare your host machine
   ```
   $ bin/setup.sh
   ```

1. Modify what you'd like and then build the packages
   ```
   $ nix-build
   ```

   Or if you'd like to test a single package, run `nix-build` directly with the package attribute

   ```
   $ nix-build -A omgmacs
   ```

1. Check the corresponding `result` symlink(s) for the package(s) you're testing. Each result symlink points to the derivation's contents in the Nix store.

## Testing

Built packages can be tested on the host machine since Nix packages are isolated, immutable, and atomic by nature. Simply build your package(s) and interact with the output in the corresponding result symlinks.

This repository also contains a `bin/setup.sh` script which installs the base development environment for all One More Game projects and, in the future, will be publicly hosted as part of our open source offerings and mod tooling. This script works on various platforms and can be tested through the use of Vagrant and VMWare Fusion.

You'll need to manually install Vagrant and VMWare Fusion. After installation, run the following script:

    ```
    $ bin/test-setup
    ```

This will start a virtual machine for all supported platforms and distributions, run the setup script, test the virtual machine, and then destroy all of the virtual machines.

> The MIT license does not apply to the packages built by this repository, but of the package descriptions found inside this repository. This license may not apply to patches used to build software artifacts. All built packages are covered by their project's respective licenses.
