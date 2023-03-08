#!/usr/bin/env bash
set -eu

PROCESSOR_NUM=$(grep cpu.cores /proc/cpuinfo | sort -u | sed 's/[^0-9]//g')
JOBS=$((PROCESSOR_NUM - 1))
