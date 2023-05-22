#!/usr/bin/env bash
set -eu

KERNEL_NAME=$(uname -s)
if [[ $KERNEL_NAME == 'Darwin' ]]; then
    PROCESSOR_NUM=$(sysctl -n hw.physicalcpu_max)
elif [[ $(echo "$KERNEL_NAME" | cut -c 1-5) == 'Linux' ]]; then
    PROCESSOR_NUM=$(grep cpu.cores /proc/cpuinfo | sort -u | sed 's/[^0-9]//g')
else
    echo "$KERNEL_NAME is not supported."
    exit 1
fi
JOBS=$((PROCESSOR_NUM - 1))
