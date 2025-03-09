#!/bin/bash
export pkgver=6.3.2
export ROCM_HOME=/opt/rocm-$pkgver/
export ROCM_PATH=$ROCM_HOME
function fetch(){
  git clone --recursive https://github.com/ggerganov/llama.cpp
}
export PATH=$ROCM_HOME/bin:$ROCM_HOME/lib/llvm/bin:$PATH
function prepare() {
  mkdir build
  cd build
  if [ -n $AMDGPU_TARGETS ] && [ $AMDGPU_TARGETS != 'all' ]; then
    targetSet=( -DAMDGPU_TARGETS=${AMDGPU_TARGETS} )
  else
    targetSet=( )
  fi
  EXT_CFLAGS="-pipe -fopenmp -Wl,-rpath=/opt/rocm-${pkgver}/lib -Wl,-rpath=/opt/rocm-${pkgver}/lib/llvm/lib -fPIC -stdlib=libc++ -Wno-gnu-line-marker -L/opt/rocm-${pkgver}/lib/llvm/lib -I/opt/rocm-${pkgver}/lib/llvm/include/c++/v1 -Wno-unused-command-line-argument -I/opt/rocm-${pkgver}/include  -L/opt/rocm-${pkgver}/lib -fexperimental-library -mcmodel=extreme"

  cmake ../llama.cpp \
   -DCMAKE_C_COMPILER=/opt/rocm-$pkgver/lib/llvm/bin/clang \
   -DCMAKE_CXX_COMPILER=/opt/rocm-$pkgver/lib/llvm/bin/amdclang++ \
   -DCMAKE_BUILD_TYPE=Release \
   -DCMAKE_CXX_FLAGS="$EXT_CFLAGS" \
   -DCMAKE_C_FLAGS="$EXT_CFLAGS" \
   -DCMAKE_HIP_FLAGS="$EXT_CFLAGS" \
   -DGGML_HIP=ON \
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
