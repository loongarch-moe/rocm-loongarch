#!/bin/bash
set -e  # 遇到错误立即终止

export pkgver=6.3.2
export ROCM_HOME=/opt/rocm-$pkgver/
export ROCM_PATH=$ROCM_HOME
export HIP_PATH=$ROCM_HOME
export PATH=$ROCM_PATH/bin:$ROCM_PATH/lib/llvm/bin:$PATH
export LD_LIBRARY_PATH=$ROCM_HOME/lib:$LD_LIBRARY_PATH

function fetch(){
  if [ -d "ollama" ]; then
    echo "目标路径 'ollama' 已存在，跳过克隆。"
  else
    git clone --recursive https://github.com/ollama/ollama.git
  fi
}

function prepare() {
  if [[ -n "$AMDGPU_TARGETS" && "$AMDGPU_TARGETS" != "all" ]]; then
    targetSet=( -DAMDGPU_TARGETS="${AMDGPU_TARGETS}" )
  else
    targetSet=( -DAMDGPU_TARGETS=gfx1100 )
  fi

  EXT_CFLAGS="-pipe -fopenmp -Wl,-rpath=/opt/rocm-${pkgver}/lib -Wl,-rpath=/opt/rocm-${pkgver}/lib/llvm/lib -fPIC -stdlib=libc++ -Wno-gnu-line-marker \
  -L/opt/rocm-${pkgver}/lib/llvm/lib -I/opt/rocm-${pkgver}/lib/llvm/include/c++/v1 -Wno-unused-command-line-argument -I/opt/rocm-${pkgver}/include \
  -L/opt/rocm-${pkgver}/lib -fexperimental-library -mcmodel=extreme"

  cd ollama  # 进入正确的源代码目录
  mkdir -p build  # 确保 build 目录存在

  cmake -B build \
    -DCMAKE_C_COMPILER=/opt/rocm-$pkgver/lib/llvm/bin/clang \
    -DCMAKE_CXX_COMPILER=/opt/rocm-$pkgver/lib/llvm/bin/clang++ \
    -DCMAKE_HIP_COMPILER=/opt/rocm-$pkgver/lib/llvm/bin/clang++ \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_CXX_FLAGS="$EXT_CFLAGS" \
    -DCMAKE_C_FLAGS="$EXT_CFLAGS" \
    -DCMAKE_HIP_FLAGS="$EXT_CFLAGS" \
    -DCMAKE_INSTALL_RPATH="/opt/rocm-${pkgver}/lib;/opt/rocm-${pkgver}/lib/llvm/lib;/opt/rocm-${pkgver}/lib64" \
    -DCMAKE_BUILD_RPATH="/opt/rocm-${pkgver}/lib;/opt/rocm-${pkgver}/lib/llvm/lib;/opt/rocm-${pkgver}/lib64" \
    "${targetSet[@]}" \
    -G "Ninja"
  cd ..
}

function build() {
  cd ollama  # 进入正确的目录
  cmake --build build --config Release
  cd ..
}

function package(){
  echo "Packaging is not implemented yet."
}

function main(){
  fetch
  prepare
  build
  # package  # 如需打包可以解除注释
}

main

