#!/bin/bash

set -ex

# packages
export DEBIAN_FRONTEND=noninteractive
sudo apt-get update -qq
sudo apt-get install -y libcap-dev openjdk-8-jdk-headless php5-cli

ls -al /usr/bin/java*

which javac || true
which java || true
which php || true

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
