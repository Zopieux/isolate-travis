#!/bin/bash

set -ex

if ! [[ $(sudo -E su $USER -c 'groups') == *isolate* ]]; then
   echo "$USER is not in isolate group"
   exit 1;
fi

which python
python --version

sudo -E su $USER -c "cd $TRAVIS_BUILD_DIR; which python; python --version; pwd; ls -al; python setup.py"
sudo -E su $USER -p -c "cd $TRAVIS_BUILD_DIR; which python; python --version; pwd; ls -al; python setup.py"

