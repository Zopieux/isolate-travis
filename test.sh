#!/bin/bash

set -ex

if ! [[ $(sudo -E su $USER -c 'groups') == *isolate* ]]; then
   echo "$USER is not in isolate group"
   exit 1;
fi

sudo -E su $USER -c \
"cd $TRAVIS_BUILD_DIR; pwd; ls -al;"\
"python setup.py"\

