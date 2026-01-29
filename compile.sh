#!/bin/bash
QMCPACK_ROOT=$(pwd)

module reset

# Load gpu offload for gfx90a
source ../setup-build-env.sh

module load PrgEnv-cray
module load amd/6.4.1
module load rocm/6.4.1
module load craype-accel-amd-gfx90a
module load cray-hdf5
module load cray-fftw
module load openblas
module load cray-mpich/8.1.31

module list

echo "ROCM PATH: $ROCM_PATH"
echo "OPENBLAS ROOT: $OLCF_OPENBLAS_ROOT"

rm -Rf build && mkdir build && cd build

export CFLAGS="-fopenmp -L$CRAY_MPICH_PREFIX/lib/ -lmpi_gtl_hsa"
export CXXFLAGS="-fopenmp -L$CRAY_MPICH_PREFIX/lib/ -lmpi_gtl_hsa"

cmake -DCMAKE_BUILD_TYPE=Release \
    -DBLAS_LIBRARIES="$OLCF_OPENBLAS_ROOT/lib/libopenblas.so" \
    -DLAPACK_LIBRARIES="$OLCF_OPENBLAS_ROOT/lib/libopenblas.so" \
    -DQMC_GPU="hip" \
    -DQMC_GPU_ARCHS="gfx90a" \
    -DQMC_MPI="on" \
    -DQMC_DATA=$QMCPACK_ROOT/QMC_DATA_FULL \
    ..

make -j64