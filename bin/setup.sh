#!/usr/bin/env bash
#
# Prepares a user's workstation to interact with a One More Game software
# project. OMG leverages Nix and Direnv to configure development
# environments on a per-project basis which is also contextual to the
# user's current working directory within their shell.
#
# This script is called without arguments and installs all prerequisite
# software and OMGmacs (a customized Emacs/Spacemacs).

set -euo pipefail

NIXSH="$HOME/.nix-profile/etc/profile.d/nix.sh"
OMG_CONFIG_DIR="$HOME/.config/omg"
OMGRC="$OMG_CONFIG_DIR/.omgrc"
OMGMACS_CONFIG="$OMG_CONFIG_DIR/user-config.el"
OS=""

if [ -f /etc/os-release ]; then
  # freedesktop.org and systemd
  . /etc/os-release
  OS=$NAME
elif type lsb_release >/dev/null 2>&1; then
  # linuxbase.org
  OS=$(lsb_release -si)
elif [ -f /etc/lsb-release ]; then
  # For some versions of Debian/Ubuntu without lsb_release command
  . /etc/lsb-release
  OS=$DISTRIB_ID
elif [ -f /etc/debian_version ]; then
  # Older Debian/Ubuntu/etc.
  OS=Debian
else
  # Fall back to uname, e.g. "Linux <version>", also works for BSD, etc.
  OS=$(uname -s)
fi

function nix_installed {
  if [ -f "$NIXSH" ]; then
    return 0
  else
    return 1
  fi
}

function source_nix {
  # shellcheck disable=2034
  MANPATH="" # Required to be set to a value for sourcing the profile below
  # shellcheck disable=1090
  source "$NIXSH"
}

function setup_debian {
  sudo apt-get update
  sudo apt-get install -y curl
}

function setup_linux {
  if command -v curl &> /dev/null ; then
    return 0
  fi
  local OS=""
  if [ -f /etc/os-release ]; then
    # freedesktop.org and systemd
    # shellcheck disable=1091
    . /etc/os-release
    OS=$NAME
  elif type lsb_release >/dev/null 2>&1; then
    # linuxbase.org
    OS=$(lsb_release -si)
  elif [ -f /etc/lsb-release ]; then
    # For some versions of Debian/Ubuntu without lsb_release command
    # shellcheck disable=1091
    . /etc/lsb-release
    OS=$DISTRIB_ID
  elif [ -f /etc/debian_version ]; then
    # Older Debian/Ubuntu/etc.
    OS=Debian
  else
    # Fall back to uname, e.g. "Linux <version>", also works for BSD, etc.
    OS=$(uname -s)
  fi
  case "${OS,,}" in
    ubuntu*|debian*)
      setup_debian
      ;;
    *)
      echo "Unsupported Linux distribution: $OS"
      echo "Manually install 'curl' and ensure it is on your path and try again."
      exit 1
      ;;
  esac
}

# Perform additional OS-specific setup
case "$OSTYPE" in
  darwin*)
    ;;

  linux*)
    setup_linux
    ;;

  msys*|cygwin*)
    ;;

  *)
    echo >&2 "Unknown OS: $OSTYPE"
    exit 1
    ;;
esac

if ! nix_installed; then
  echo "Installing Nix..."
  curl -fsSL https://nixos.org/nix/install | sh
fi

source_nix

if ! command direnv &> /dev/null; then
  echo "Installing direnv..."
  nix-env -i direnv
fi

mkdir -p "$OMG_CONFIG_DIR"

if [ ! -f "$OMGRC" ]; then
  echo "Writing '$OMGRC'..."
  cat << EOF >> "$OMGRC"
# Load direnv
case "\$SHELL" in
  */bash)
    eval "\$(direnv hook bash)"
    ;;
  */zsh)
    eval "\$(direnv hook zsh)"
    ;;
  *)
    ;;
esac
EOF
fi

if [ -f "$HOME/.profile" ]; then
  if ! grep "source \"$HOME/.config/omg/.omgrc\"" "$HOME/.profile" &> /dev/null; then
    echo "source \"$HOME/.config/omg/.omgrc\"" >> "$HOME/.profile"
  fi
fi

if [ ! -f "$OMGMACS_CONFIG" ]; then
  mkdir -p "$(dirname "$OMGMACS_CONFIG")"
  cat << EOF >> "$OMGMACS_CONFIG"
;; -*- mode: emacs-lisp -*-
;; This file is loaded by OMGmacs at startup.
;; It must be stored at '\$HOME/.config/omg/user-config.el'.

(defun omg/user-init ()
  "Initialization function for user code.
It is called at the end of 'dotspacemacs/user-init' which is called immediately
after 'dotspacemacs/init', before layer configuration executes.

This function is mostly useful for variables that need to be set before packages are
loaded. If you are unsure, you should try in setting variables here, first."
  ;; Add configuration here
  )

(defun omg/user-config ()
  "Configuration function for user code.
This function is called at the end of 'dotspacemacs/user-config' which is called
at the very end of Spacemacs initialization after layers configuration.

This is the place where most of your configurations should be done. Unless it is
explicitly specified that a variable should be set before a package is loaded,
you should place your code here."
  ;; Add configuration here
  )

EOF
fi

echo ""
echo "***************"
echo "Setup complete!"
echo "***************"
echo ""
echo "Your OMG shell environment can be customized by editing '$OMGRC'."
echo ""
echo "You will need to allow the source tree's direnv configuration to modify your"
echo "shell by running:"
echo ""
echo "    $ direnv allow"
echo ""
echo "Direnv will populate your shell environment and modify it's path to include"
echo "all of the tools you will need to work with the OMG development environment."
echo "A customized Emacs editor based on Spacemacs will be installed as part of"
echo "this development environment. It can started with:"
echo ""
echo "    $ omge"
echo ""
echo "You can customize the editor by editing your user configuration at:"
echo ""
echo "    $OMGMACS_CONFIG"
echo ""
echo "Please restart your shell to continue."
