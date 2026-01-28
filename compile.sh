#!/bin/bash
module purge

source ../setup-build-env.sh
export QMCPACK_ROOT=$(pwd)
export PREFIX=$QMCPACK_ROOT/install
rm -rf $QMCPACK_ROOT/build $QMCPACK_ROOT/CMakeCache.txt $QMCPACK_ROOT/CMakeFiles

export CFLAGS="-fopenmp"
export CXXFLAGS="-fopenmp"

mkdir build && cd build
cmake -DCMAKE_BUILD_TYPE=Release \
    -DQMC_GPU="openmp;hip" \
    -DQMC_GPU_ARCHS="gfx90a" \
    -DQMC_MPI="on" \
    -DQMC_DATA=$QMCPACK_ROOT/QMC_DATA_FULL \
    ..

make -j64