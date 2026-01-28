#!/bin/bash

QMCPACK_ROOT=$(pwd)

source ../setup-run-env.sh
if [ -f ../profiler-injector.sh ]; then
    source ../profiler-injector.sh
fi

export OMP_NUM_THREADS=4
srun -A csc688 -t10 -N1 -c7 -n8 --gpu-bind=closest $QMCPACK_ROOT/build/bin/qmcpack /lustre/orion/csc688/world-shared/interceptor-bench/qmcpack/build/tests/performance/NiO/dmc-a512-e6144-DU64-batched_driver/NiO-fcc-S128-dmc.xml

