#!/bin/bash
export ROCM_HOME=/opt/rocm-next/
export CUPY_INSTALL_USE_HIP=1
export HCC_AMDGPU_TARGET=gfx1030
export CC=$ROCM_HOME/bin/clang
export CXX=$ROCM_HOME/bin/clang++

function fetch() {
  if [ ! -d cupy.git ]
  then
    git clone --bare https://github.com/cupy/cupy.git -b main || true
  else
    cd cupy.git
      git fetch
    cd ..
  fi
}
function prepare() {
  python3.12 -m venv build-env
  source build-env/bin/activate
  pip install setuptools cython==0.29.37 wheel
  if [ ! -d cupy ]
  then
    git clone cupy.git || true
  else
    cd cupy
    git reset --hard
    git pull
    cd ..
  fi
  cd cupy
    git reset --hard
    git submodule update --init
    git apply ../cupy.patch
  cd ..
}
function build() {
  source build-env/bin/activate
  cd cupy
    python setup.py build
  cd ..
}
function package(){
  source build-env/bin/activate
  cd cupy
    python setup.py bdist_wheel
    cp dist/cupy-*.whl ..
  cd ..
}

function main(){
  fetch
  prepare
  build
  package
}
main
