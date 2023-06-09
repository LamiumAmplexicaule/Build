#!/usr/bin/env bash
set -eu

PYTHON=${PYTHON="python3"}
PYTORCH_BRANCH=${PYTORCH_BRANCH="main"}

SCRIPT_DIR=$(cd "$(dirname "$0")"; pwd)
source "$SCRIPT_DIR"/../definition.sh

mkdir -p build_pytorch_vulkan
cd build_pytorch_vulkan

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
python3 setup.py clean
MAX_JOBS=$JOBS PYTHONPATH=$(pwd) USE_VULKAN=1 USE_CUDA=0 python3 setup.py bdist_wheel

cd ../
cp ./pytorch/dist/*.whl .

pip install *.whl

if [[ ! -d "vision" ]]; then
    git clone -b $TORCHVISION_BRANCH --recursive https://github.com/pytorch/vision
fi

cd vision
python3 setup.py clean
MAX_JOBS=$JOBS python3 setup.py bdist_wheel
cd ../
cp ./vision/dist/*.whl .
