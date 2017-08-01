#!/bin/bash

set -ex

if ! [[ $(sudo -E su $USER -c 'groups') == *isolate* ]]; then
   echo "$USER is not in isolate group"
   exit 1;
fi

which python
python --version

sudo -E su $USER -c "set -x; cd $TRAVIS_BUILD_DIR; source $VIRTUAL_ENV/bin/activate; which python; python --version; pwd; ls -al; python setup.py"

