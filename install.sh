#!/bin/bash

set -ex

# packages
export DEBIAN_FRONTEND=noninteractive
sudo apt-get update -qq
sudo apt-get install -yqq libcap-dev coreutils build-essential ghc-dynamic

ls -al /usr/lib/ghc/package.conf.d
gcc -print-prog-name=ld
which ld
dpkg -V binutils

# build isolate
pushd /tmp
git clone --depth=1 https://github.com/ioi/isolate.git
pushd isolate
make PREFIX="/usr" VARPREFIX="/var" CONFIGDIR="/etc" isolate

# install isolate
sudo make PREFIX="/usr" VARPREFIX="/var" CONFIGDIR="/etc" install

# use a non-autistic path
sudo sed -i "s|/var/local/lib/isolate|/var/lib/isolate|" /etc/isolate

# group & setuid stuff
sudo groupadd isolate
sudo usermod -a -G isolate $USER
sudo chown -v root:isolate /usr/bin/isolate
sudo chmod -v u+s /usr/bin/isolate
