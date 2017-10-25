#!/bin/bash
# For why we use auditwheel see: https://github.com/pypa/auditwheel

PATCHELF_VERSION=6bfcafbba8d89e44f9ac9582493b4f27d9d8c369

set -ex

curl -sL -o patchelf.tar.gz https://github.com/NixOS/patchelf/archive/$PATCHELF_VERSION.tar.gz
tar -xzf patchelf.tar.gz
(cd patchelf-$PATCHELF_VERSION && ./bootstrap.sh && ./configure && make && make install)
rm -rf patchelf.tar.gz patchelf-$PATCHELF_VERSION

if $(python --version | grep 3 &>/dev/null) ; then
  pip install auditwheel
else  # For python 2, we need python >=3.3 for auditwheel
  yum install -y python34-pip
  pip-3.4 install auditwheel
fi

pip install wheel
