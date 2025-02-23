#!/bin/bash
echo "使用ROCm的llvm仅为了简化依赖和测试，如有必要可更换"
export pkgver=6.3.2
export ROCM_HOME=/opt/rocm-$pkgver/
export ROCM_PATH=$ROCM_HOME
function fetch(){
  git clone --recursive https://github.com/ggerganov/llama.cpp
}
function prepare() {
  mkdir build-cpu-sx
  cd build-cpu-sx

  cmake ../llama.cpp \
   -DCMAKE_C_COMPILER=/opt/rocm-$pkgver/lib/llvm/bin/clang \
   -DCMAKE_CXX_COMPILER=/opt/rocm-$pkgver/lib/llvm/bin/clang++ \
   -DCMAKE_BUILD_TYPE=Release \
   -DCMAKE_LINKER_TYPE=LLD  \
   -DCMAKE_CXX_FLAGS="-I/opt/rocm-${pkgver}/include -stdlib=libc++ -fopenmp" \
   -DGGML_LSX=ON \
   -DGGML_LASX=ON \
   -DCMAKE_INSTALL_RPATH="/opt/rocm-${pkgver}/lib;/opt/rocm-${pkgver}/lib/llvm/lib;/opt/rocm-${pkgver}/lib64" \
   -DCMAKE_BUILD_RPATH="/opt/rocm-${pkgver}/lib;/opt/rocm-${pkgver}/lib/llvm/lib;/opt/rocm-${pkgver}/lib64" \
   -G "Ninja"
  cd ..
}
function build() {
  cd build-cpu-sx
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

