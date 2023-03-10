#!/usr/bin/env bash
set -eu

PYTORCH_BRANCH=${PYTORCH_BRANCH="master"}
ANDROID_ABI=${ANDROID_ABI="arm64-v8a"}

mkdir -p build_pytorch_android_vulkan
cd build_pytorch_android_vulkan

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
python3 setup.py clean
PYTHONPATH=$(pwd) ANDROID_HOME=${ANDROID_HOME:?} ANDROID_NDK=${ANDROID_NDK:?} BUILD_LITE_INTERPRETER=0 USE_VULKAN=1 bash ./scripts/build_pytorch_android.sh $ANDROID_ABI

cd ../
find . -type f -name '*.aar' | xargs -I{} cp {} .
