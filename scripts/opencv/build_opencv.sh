#!/usr/bin/env bash
set -eu

OPENCV_BRANCH=${OPENCV_BRANCH="master"}

SCRIPT_DIR=$(cd $(dirname $0); pwd)
source $SCRIPT_DIR/../definition.sh

mkdir -p build_opencv
cd build_opencv

if [[ ! -d "opencv" ]]; then
    git clone -b $OPENCV_BRANCH --recursive https://github.com/opencv/opencv.git
fi
if [[ ! -d "opencv_contrib" ]]; then
    git clone -b $OPENCV_BRANCH --recursive https://github.com/opencv/opencv_contrib.git
fi

mkdir -p build
cd build
cmake -D CMAKE_BUILD_TYPE=RELEASE \
-D OPENCV_GENERATE_PKGCONFIG=ON \
-D BUILD_EXAMPLES=OFF \
-D WITH_CUDA=ON \
-DOPENCV_EXTRA_MODULES_PATH=../opencv_contrib/modules \
../opencv
make -j$JOBS
