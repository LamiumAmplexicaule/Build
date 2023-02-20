#!/usr/bin/env bash
set -eu

PYTORCH_BRANCH=${PYTORCH_BRANCH="master"}

mkdir -p build_pytorch
cd build_pytorch

if [[ ! -d "build_venv" ]]; then
    python3 -m venv build_venv
fi

source ./build_venv/bin/activate

pip3 install astunparse numpy ninja pyyaml setuptools cmake cffi typing_extensions future six requests dataclasses
pip3 install mkl mkl-include

if [[ ! -d "pytorch" ]]; then
    git clone -b $PYTORCH_BRANCH --recursive https://github.com/pytorch/pytorch.git
fi

cd pytorch
git submodule sync
git submodule update --init --recursive
python3 setup.py clean
python3 setup.py bdist_wheel

cd ../
cp ./pytorch/dist/*.whl .
