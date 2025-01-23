#!/bin/bash
export pkgver=6.3.1
export ROCM_HOME=/opt/rocm-$pkgver/
export ROCM_PATH=$ROCM_HOME
function fetch(){
  git clone --recursive https://github.com/leejet/stable-diffusion.cpp
}
function prepare() {
  mkdir build
  cd build
  if [ -n $AMDGPU_TARGETS ] && [ $AMDGPU_TARGETS != 'all' ]; then
    targetSet=( -DAMDGPU_TARGETS=${AMDGPU_TARGETS} )
  else
    targetSet=( )
  fi

  cmake ../stable-diffusion.cpp \
   -DCMAKE_C_COMPILER=/opt/rocm-$pkgver/lib/llvm/bin/clang \
   -DCMAKE_CXX_COMPILER=/opt/rocm-$pkgver/bin/hipcc \
   -DCMAKE_BUILD_TYPE=Release \
   -DAMDGPU_TARGETS=gfx1100 \
   -DCMAKE_LINKER_TYPE=LLD  \
   -DCMAKE_CXX_FLAGS="-I/opt/rocm-${pkgver}/include -stdlib=libc++ -fopenmp -parallel-jobs=$(nproc) " \
   -DGGML_HIP=ON \
   -DSD_HIPBLAS=ON \
   -DCMAKE_INSTALL_RPATH="/opt/rocm-${pkgver}/lib;/opt/rocm-${pkgver}/lib/llvm/lib;/opt/rocm-${pkgver}/lib64" \
   -DCMAKE_BUILD_RPATH="/opt/rocm-${pkgver}/lib;/opt/rocm-${pkgver}/lib/llvm/lib;/opt/rocm-${pkgver}/lib64" \
   ${targetSet[@]} \
   -G "Ninja"
  cd ..
}
function build() {
  cd build
    ninja
  cd ..
}
function package(){
  echo 
}

function main(){
  fetch
  prepare
  build
#  package
}
main

