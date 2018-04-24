#!/bin/bash
set -eou pipefail

invalid_args() {
  echo "Error: Invalid arguments."
  echo "  The command syntax is install-cmake <version> <build>"
  echo "  Example: install-cmake 3.11 0"
  exit 1
}

[[ $# -lt 2 ]] && { invalid_args; }

# Command args
version=$1
build=$2

echo "Installing cmake v$version.$build..."

# Installs cmake directly from cmake.org, since apt-get
# often doesn't have the latest versions
installer=cmake-$version.$build-Linux-x86_64.sh
wget -q "https://cmake.org/files/v$version/$installer" -P ~/
mkdir /opt/cmake
sh ~/$installer --prefix=/opt/cmake --skip-license
ln -s /opt/cmake/bin/cmake /usr/local/bin/cmake
rm -f ~/$installer
cmake --version
