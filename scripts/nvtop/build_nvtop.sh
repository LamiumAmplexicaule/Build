#!/usr/bin/env bash
set -eu

#sudo apt-get -y install libdrm-dev libsystemd-dev
#sudo apt-get -y install cmake libncurses5-dev libncursesw5-dev git

mkdir -p build_nvtop
cd build_nvtop

CPU_VENDOR=$(grep vendor_id /proc/cpuinfo | cut -d ":" -f2)
if [[ $CPU_VENDOR == *GenuineIntel* ]]; then
    CMAKE_BUILD_OPTIONS=(-DINTEL_SUPPORT=ON)
fi

GPU=$(lspci | grep VGA | cut -d ":" -f3)
if [[ $GPU == *NVIDIA* ]]; then
    CMAKE_BUILD_OPTIONS+=(-DNVIDIA_SUPPORT=ON)
elif [[ $GPU == *Advanced* ]]; then
    CMAKE_BUILD_OPTIONS+=(-DAMDGPU_SUPPORT=ON)
fi

if [[ ! -d "nvtop" ]]; then
    git clone https://github.com/Syllo/nvtop.git
fi

mkdir -p build && cd build
cmake ../nvtop "${CMAKE_BUILD_OPTIONS[@]}"
make

while true; do
    read -rp "Install nvtop? (y/n) " yn
    case $yn in 
    	[yY] ) sudo make install
    		break;;
    	* ) echo exit;
    		exit;;
    esac
done