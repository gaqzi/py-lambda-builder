#!/bin/bash

if [ -z "$1" ] ; then
  echo "Usage: [-b] <arguments to pip wheel>"
  echo "  -b  Bundle any non-standard C libraries. Mostly needed"
  echo "      when you have to install some external library"
  echo "  -p  The Python version to compile for, default: 2.7"
  exit 1
fi

BUNDLE_LIBRARIES=false
PYTHON_VERSION=2.7

while getopts bp: opt ; do
    case ${opt} in
        b)
            BUNDLE_LIBRARIES=true
            shift
            ;;
        p)
            PYTHON_VERSION=${OPTARG}
            shift 2
            ;;
    esac
done

function cmd() {
    echo "+ $@" >&2
    $@
}

function pip-cmd() {
    local version="$1"
    shift

    cmd pip${version} $@
}

function rename-manylinux-wheels-to-linux() {
    # Pants doesn't find manylinux packages, but it does work if we
    # simply rename them to linux instead of manylinux. So that's good
    # enough for me!
    for wheel in *.whl ; do
        echo "$wheel" | grep -- '-manylinux1_' &>/dev/null && \
            cmd mv "${wheel}" "${wheel/-manylinux1_/-linux_}"
    done
}

function move-wheel-into-place() {
  local bundle="$1"

  if [ "${bundle}" = 'true' ] ; then
    cmd auditwheel repair -w /wheelhouse --plat linux_x86_64 *.whl
  else
    cmd mv *.whl /wheelhouse
  fi
}

pip-cmd ${PYTHON_VERSION} wheel $@

rename-manylinux-wheels-to-linux
move-wheel-into-place "${BUNDLE_LIBRARIES}"
