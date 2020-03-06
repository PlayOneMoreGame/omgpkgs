#!/usr/bin/env bash
#
# Prepares a user's workstation to interact with a One More Game software
# project. OMG leverages Nix and Direnv to configure development
# environments on a per-project basis which is also contextual to the
# user's current working directory within their shell.
#
# This script is called without arguments and installs all prerequisite
# software and OMGmacs (a customized Emacs/Spacemacs).
#
# shellcheck disable=SC1091

set -euo pipefail

readonly NIXSH="$HOME/.nix-profile/etc/profile.d/nix.sh"
readonly OMG_CONFIG_DIR="$HOME/.config/omg"
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

function source_nix() {
  # shellcheck disable=2034
  MANPATH="" # Required to be set to a value for sourcing the profile below
  # shellcheck disable=1090
  source "$NIXSH"
}

function setup_debian() {
  # Disable interactive prompts from debian/ubuntu packages when upgrading apt
  export DEBIAN_FRONTEND=noninteractive
  sudo apt-get update
  sudo apt-get install -y curl
}

function setup_linux() {
  if command -v curl &>/dev/null; then
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
  ubuntu* | debian*)
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
darwin*) ;;
linux*)
  setup_linux
  ;;
msys* | cygwin*) ;;
*)
  echo >&2 "Unknown OS: $OSTYPE"
  exit 1
  ;;
esac

# Check if Nix is installed and if not, install for the current user
if [ ! -f "$HOME/.nix-profile/bin/nix" ]; then
  echo "Installing Nix..."
  curl -fsSL https://nixos.org/nix/install | sh
fi

source_nix

if ! command direnv &>/dev/null; then
  echo "Installing direnv..."
  nix-env -i direnv
fi

if ! command git &>/dev/null; then
  echo "Installing git..."
  nix-env -i git
fi

if ! command git-lfs &>/dev/null; then
  echo "Installing git-lfs..."
  nix-env -i git-lfs
fi

mkdir -p "$OMG_CONFIG_DIR"

if [ -f "$HOME/.bashrc" ]; then
  if ! grep 'eval "$(direnv hook bash)"' "$HOME/.bashrc" &>/dev/null; then
    echo "" >>"$HOME/.bashrc"
    echo "eval \"\$(direnv hook bash)\"" >>"$HOME/.bashrc"
  fi
fi

if [ -f "$HOME/.zshrc" ]; then
  if ! grep 'eval "$(direnv hook zsh)"' "$HOME/.zshrc" &>/dev/null; then
    echo "" >>"$HOME/.zshrc"
    echo "eval \"\$(direnv hook zsh)\"" >>"$HOME/.zshrc"
  fi
fi

echo ""
echo "***************"
echo "Setup complete!"
echo "***************"
echo ""
echo "Please restart your shell before continuing."
echo ""
echo "Once your shell has been restarted, you will need to allow the source tree's"
echo "direnv configuration to modify your shell by running:"
echo ""
echo "    $ direnv allow"
echo ""
echo "Direnv will populate your shell environment and modify it's path to include"
echo "all of the tools you will need to work with the OMG development environment."

if [[ $(uname -r) =~ icrosoft ]]; then
  echo ""
  echo "IMPORTANT: You are running on WSL (Windows Subsytem for Linux), and so it"
  echo "may be necessary to restart your WSL session using \`wsl.exe --shutdown\`"
  echo "in order for changes to your \`.profile\` file to be sourced."
fi
