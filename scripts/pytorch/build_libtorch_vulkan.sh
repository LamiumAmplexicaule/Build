#!/usr/bin/env bash
set -eu

PYTORCH_BRANCH=${PYTORCH_BRANCH="master"}

mkdir -p build_libtorch_vulkan
cd build_libtorch_vulkan

if [[ ! -d "build_venv" ]]; then
    python3 -m venv build_venv
fi

source ./build_venv/bin/activate

pip3 install astunparse numpy ninja pyyaml setuptools cmake cffi typing_extensions future six requests dataclasses
pip3 install mkl mkl-include

if [[ ! -d "pytorch" ]]; then
    git clone -b $PYTORCH_BRANCH --recurse https://github.com/pytorch/pytorch.git
fi

cd pytorch
git submodule sync
git submodule update --init --recursive
cd ..

mkdir -p pytorch-build
cd pytorch-build
PYTHONPATH="../pytorch" cmake -DUSE_CUDA=OFF -DUSE_VULKAN:BOOL=ON -DBUILD_SHARED_LIBS:BOOL=ON -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_BUILD_TYPE:STRING=Release -DPYTHON_EXECUTABLE:PATH=`which python3` -DCMAKE_INSTALL_PREFIX:PATH=../pytorch-install ../pytorch
cmake --build . --target install -j6
