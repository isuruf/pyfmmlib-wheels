#!/bin/bash

mkdir -p dist
cd dist

version=$1

if [[ "$1" == "" ]]; then
    echo "Usage: down_them_all.sh <version>"
    exit 1
fi

declare -a arr=("cp27-cp27m-macosx_10_6_intel.macosx_10_9_intel.macosx_10_9_x86_64.macosx_10_10_intel.macosx_10_10_x86_64.whl" "cp27-cp27m-manylinux1_i686.whl" "cp27-cp27m-manylinux1_x86_64.whl" "cp27-cp27mu-manylinux1_i686.whl" "cp27-cp27mu-manylinux1_x86_64.whl" "cp34-cp34m-macosx_10_6_intel.macosx_10_9_intel.macosx_10_9_x86_64.macosx_10_10_intel.macosx_10_10_x86_64.whl" "cp34-cp34m-manylinux1_i686.whl" "cp34-cp34m-manylinux1_x86_64.whl" "cp35-cp35m-manylinux1_i686.whl" "cp35-cp35m-manylinux1_x86_64.whl" "cp36-cp36m-macosx_10_6_intel.macosx_10_9_intel.macosx_10_9_x86_64.macosx_10_10_intel.macosx_10_10_x86_64.whl" "cp36-cp36m-manylinux1_i686.whl" "cp36-cp36m-manylinux1_x86_64.whl" "cp37-cp37m-macosx_10_6_intel.macosx_10_9_intel.macosx_10_9_x86_64.macosx_10_10_intel.macosx_10_10_x86_64.whl" "cp37-cp37m-manylinux1_i686.whl" "cp37-cp37m-manylinux1_x86_64.whl")

for whl_file in "${arr[@]}"
do
    curl -L -O https://github.com/isuruf/pyfmmlib-wheels/releases/download/v$version/pyfmmlib-$version-$whl_file;
done
