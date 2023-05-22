#!/usr/bin/env bash
set -eu

PYTHON=${PYTHON="python3"}
PYTORCH_BRANCH=${PYTORCH_BRANCH="main"}

SCRIPT_DIR=$(cd $(dirname $0); pwd)
source $SCRIPT_DIR/../definition.sh

mkdir -p build_libtorch
cd build_libtorch

if [[ ! -d "build_venv" ]]; then
    $PYTHON -m venv build_venv
fi

source ./build_venv/bin/activate

pip3 install -U pip
pip3 install wheel
pip3 install astunparse numpy ninja pyyaml setuptools cmake cffi typing_extensions future six requests dataclasses
if [[ $(arch) == x86_64 ]]; then
    pip3 install mkl mkl-include
fi

if [[ ! -d "pytorch" ]]; then
    git clone -b $PYTORCH_BRANCH --recurse https://github.com/pytorch/pytorch.git
fi

cd pytorch
git submodule sync
git submodule update --init --recursive
cd ..

mkdir -p pytorch-build
cd pytorch-build
cmake -DBUILD_SHARED_LIBS:BOOL=ON -DCMAKE_BUILD_TYPE:STRING=Release -DPYTHON_EXECUTABLE:PATH=`which python3` -DCMAKE_INSTALL_PREFIX:PATH=../pytorch-install ../pytorch
cmake --build . --target install -j$JOBS
