#!/bin/bash

QMCPACK_ROOT=$(pwd)

source ../setup-run-env.sh

module load PrgEnv-cray
module load amd/6.4.1
module load rocm/6.4.1
module load craype-accel-amd-gfx90a
module load cray-hdf5
module load cray-fftw
module load openblas
module load cray-mpich/8.1.31

if [ -f ../profiler-injector.sh ]; then
    source ../profiler-injector.sh
fi

ldd $QMCPACK_ROOT/build/bin/qmcpack

export OMP_NUM_THREADS=4
srun -A csc688 -t10 -N1 -c7 -n8 --gpu-bind=closest $QMCPACK_ROOT/build/bin/qmcpack /lustre/orion/csc688/world-shared/interceptor-bench/li-qmcpack/examples/molecules/He/he_simple.xml

