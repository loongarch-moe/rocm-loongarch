#!/bin/bash
export ROCM_HOME=/opt/rocm-next/
export CC=$ROCM_HOME/bin/clang
export CXX=$ROCM_HOME/bin/clang++
function _fetch() {
  if [ ! -d $1 ]
  then
    git clone --bare $2 -b $3 || true
  else
    cd $1
      git fetch
    cd ..
  fi
}
function _clone() {
  if [ ! -d $1 ]
  then
    git clone $1.git -b $2 || true
  else
    cd $1
    git reset --hard
    git pull
    cd ..
  fi
}
function _clone_m() {
  if [ ! -d $1 ]
  then
    git clone $1.git -b $2 || true
  fi
  cd $1
  git reset --hard
  git pull
  git reset --hard $3
  cd ..
}
function fetch() {
  _fetch abseil-cpp.git            https://github.com/abseil/abseil-cpp.git                              master
  _fetch pytorch.git               https://github.com/pytorch/pytorch.git                                main
  _fetch pybind11.git              https://github.com/pybind/pybind11.git                                master
  _fetch cub.git                   https://github.com/NVlabs/cub.git                                     main
  _fetch eigen.git                 https://gitlab.com/libeigen/eigen.git                                 master
  _fetch googletest.git            https://github.com/google/googletest.git                              main
  _fetch benchmark.git             https://github.com/google/benchmark.git                               main
  _fetch protobuf.git              https://github.com/protocolbuffers/protobuf.git                       main
  _fetch ios-cmake.git             https://github.com/Yangqing/ios-cmake.git                             master
  _fetch NNPACK.git                https://github.com/Maratyszcza/NNPACK.git                             master
  _fetch gloo.git                  https://github.com/facebookincubator/gloo.git                         main
  _fetch pthreadpool.git           https://github.com/Maratyszcza/pthreadpool.git                        master
  _fetch FXdiv.git                 https://github.com/Maratyszcza/FXdiv.git                              master
  _fetch FP16.git                  https://github.com/Maratyszcza/FP16.git                               master
  _fetch psimd.git                 https://github.com/Maratyszcza/psimd.git                              master
  _fetch zstd.git                  https://github.com/facebook/zstd.git                                  dev
  # _fetch cpuinfo.git               https://github.com/pytorch/cpuinfo.git                                main
  _fetch cpuinfo.git               https://github.com/33749110/cpuinfo.git                               master

  _fetch PeachPy.git               https://github.com/malfet/PeachPy.git                                 master
  _fetch onnx.git                  https://github.com/onnx/onnx.git                                      main
  _fetch onnx-tensorrt.git         https://github.com/onnx/onnx-tensorrt.git                             main
  _fetch sleef.git                 https://github.com/shibatch/sleef.git                                 master
  _fetch ideep.git                 https://github.com/intel/ideep                                        master
  _fetch nccl.git                  https://github.com/NVIDIA/nccl                                        master
  _fetch gemmlowp.git              https://github.com/google/gemmlowp.git                                master
  _fetch QNNPACK.git               https://github.com/pytorch/QNNPACK.git                                master
  _fetch ARM_NEON_2_x86_SSE.git    https://github.com/intel/ARM_NEON_2_x86_SSE.git                       master
  _fetch fbgemm.git                https://github.com/pytorch/fbgemm.git                                 main
  _fetch foxi.git                  https://github.com/houseroad/foxi.git                                 master
  _fetch tbb.git                   https://github.com/01org/tbb.git                                      tbb_2018
  _fetch fbjni.git                 https://github.com/facebookincubator/fbjni.git                        main
  _fetch XNNPACK.git               https://github.com/google/XNNPACK.git                                 master
  _fetch fmt.git                   https://github.com/fmtlib/fmt.git                                     10.x
  _fetch tensorpipe.git            https://github.com/pytorch/tensorpipe.git                             main
  _fetch cudnn-frontend.git        https://github.com/NVIDIA/cudnn-frontend.git                          main
  _fetch kineto.git                https://github.com/pytorch/kineto.git                                 main
  _fetch pocketfft.git             https://github.com/mreineck/pocketfft.git                             cpp
  _fetch ittapi.git                https://github.com/intel/ittapi.git                                   master
  _fetch flatbuffers.git           https://github.com/google/flatbuffers.git                             master
  _fetch json.git                  https://github.com/nlohmann/json.git                                  master
  _fetch VulkanMemoryAllocator.git https://github.com/GPUOpen-LibrariesAndSDKs/VulkanMemoryAllocator.git master
  _fetch cutlass.git               https://github.com/NVIDIA/cutlass.git                                 main
  _fetch mimalloc.git              https://github.com/microsoft/mimalloc.git                             dev
  _fetch asmjit.git                https://github.com/asmjit/asmjit.git                                  dev
  _fetch hipify_torch.git          https://github.com/ROCmSoftwarePlatform/hipify_torch.git              master
  _fetch libuv.git                 https://github.com/libuv/libuv.git                                    v1.x
  _fetch libnop.git                https://github.com/google/libnop.git                                  master
  _fetch dynolog.git               https://github.com/facebookincubator/dynolog.git                      main

}
function _ln (){
  rm -rf $2
  ln -s $PWD/$1 $2
}
function prepare() {
  _clone_m abseil-cpp          master 20230802.0
  _clone pytorch               main
  _clone pybind11              master
  _clone cub                   main
  _clone eigen                 master
  _clone googletest            main
  _clone benchmark             main
  _clone_m protobuf            main v3.13.0
  _clone ios-cmake             master
  _clone NNPACK                master
  _clone gloo                  main
  _clone pthreadpool           master
  _clone FXdiv                 master
  _clone FP16                  master
  _clone psimd                 master
  _clone zstd                  dev
  #_clone cpuinfo               main
  _clone cpuinfo               master
  _clone PeachPy               master
  #_clone onnx                  main
  _clone_m onnx                main v1.14.1
  _clone onnx-tensorrt         main
  # _clone sleef                 master
  _clone_m sleef               master 3.5.1
  _clone ideep                 master
  _clone nccl                  master
  _clone gemmlowp              master
  _clone QNNPACK               master
  _clone ARM_NEON_2_x86_SSE    master
  _clone fbgemm                main
  _clone foxi                  master
  _clone tbb                   tbb_2018
  _clone fbjni                 main
  _clone XNNPACK               master
  _clone fmt                   10.x
  _clone tensorpipe            main
  _clone cudnn-frontend        main
  _clone kineto                main
  _clone pocketfft             cpp
  _clone ittapi                master
  _clone_m flatbuffers         master   v23.3.3
  _clone json                  master
  _clone VulkanMemoryAllocator master
  _clone cutlass               main
  _clone mimalloc              dev
  _clone asmjit                dev
  _clone hipify_torch          master
  _clone libuv                 v1.x
  _clone libnop                master
  _clone dynolog               main
  _ln pybind11 pytorch/third_party/pybind11
  _ln cub pytorch/third_party/cub
  _ln eigen pytorch/third_party/eigen
  _ln googletest pytorch/third_party/googletest
  _ln benchmark pytorch/third_party/benchmark
  _ln protobuf pytorch/third_party/protobuf
  _ln ios-cmake pytorch/third_party/ios-cmake
  _ln NNPACK pytorch/third_party/NNPACK
  _ln gloo pytorch/third_party/gloo
  _ln pthreadpool pytorch/third_party/pthreadpool
  mkdir pytorch/third_party/NNPACK_deps || true
  _ln pthreadpool pytorch/third_party/NNPACK_deps/pthreadpool
  _ln FXdiv pytorch/third_party/FXdiv
  _ln FXdiv pytorch/third_party/NNPACK_deps/FXdiv
  _ln FP16 pytorch/third_party/FP16
  _ln FP16 pytorch/third_party/NNPACK_deps/FP16
  _ln psimd pytorch/third_party/psimd
  _ln psimd pytorch/third_party/NNPACK_deps/psimd
  _ln zstd pytorch/third_party/zstd
  _ln cpuinfo pytorch/third_party/cpuinfo
  _ln PeachPy pytorch/third_party/python-peachpy
  _ln onnx pytorch/third_party/onnx
  _ln onnx-tensorrt pytorch/third_party/onnx-tensorrt
  _ln sleef pytorch/third_party/sleef
  _ln ideep pytorch/third_party/ideep
  _ln nccl pytorch/third_party/nccl/nccl
  _ln gemmlowp pytorch/third_party/gemmlowp/gemmlowp
  _ln QNNPACK pytorch/third_party/QNNPACK
  _ln ARM_NEON_2_x86_SSE pytorch/third_party/neon2sse
  _ln fbgemm pytorch/third_party/fbgemm
  _ln foxi pytorch/third_party/foxi
  _ln tbb pytorch/third_party/tbb
  _ln fbjni pytorch/android/libs/fbjni
  _ln XNNPACK pytorch/third_party/XNNPACK
  _ln fmt pytorch/third_party/fmt
  _ln tensorpipe pytorch/third_party/tensorpipe
  _ln cudnn-frontend pytorch/third_party/cudnn_frontend
  _ln kineto pytorch/third_party/kineto
  _ln pocketfft pytorch/third_party/pocketfft
  _ln ittapi pytorch/third_party/ittapi
  _ln flatbuffers pytorch/third_party/flatbuffers
  _ln json pytorch/third_party/nlohmann
  _ln VulkanMemoryAllocator pytorch/third_party/VulkanMemoryAllocator
  _ln cutlass pytorch/third_party/cutlass
  _ln mimalloc pytorch/third_party/mimalloc
  _ln asmjit fbgemm/third_party/asmjit
  _ln cpuinfo fbgemm/third_party/cpuinfo
  _ln googletest fbgemm/third_party/googletest
  _ln hipify_torch fbgemm/third_party/hipify_torch
  _ln cutlass fbgemm/third_party/cutlass
  _ln benchmark onnx/third_party/benchmark
  _ln libuv tensorpipe/third_party/libuv
  _ln libnop tensorpipe/third_party/libnop
  _ln dynolog kineto/libkineto/third_party/dynolog
  cd sleef
    git apply ../sleef.patch
  cd ..
  python3.12 -m venv build-env
  source build-env/bin/activate
  pip install setuptools wheel
  #pip install -r pytorch/requirements.txt
  pip install \
    astunparse \
    'expecttest!=0.2.0' \
    hypothesis \
    numpy \
    psutil \
    pyyaml \
    requests \
    setuptools \
    types-dataclasses \
    'typing-extensions>=4.8.0' \
    sympy \
    filelock \
    networkx \
    jinja2 \
    fsspec \
    packaging \
    lark
  cd abseil-cpp
    sed -i \
      -e '/"-maes",/d' \
      -e '/"-msse4.1",/d' \
      -e '/"-mfpu=neon"/d' \
      -e '/"-march=armv8-a+crypto"/d' \
      absl/copts/copts.py || die
    python absl/copts/generate_copts.py
  cd ..
  mkdir build-abseil
  cd build-abseil
    cmake ../abseil-cpp \
      -G Ninja \
      -DCMAKE_INSTALL_PREFIX=$PWD/../rel-abseil/ \
      -DCMAKE_CXX_STANDARD=14 \
      -DABSL_ENABLE_INSTALL=TRUE \
      -DABSL_USE_EXTERNAL_GOOGLETEST=ON \
      -DABSL_PROPAGATE_CXX_STD=TRUE \
      -DABSL_BUILD_TEST_HELPERS=OFF \
      -DABSL_BUILD_TESTING=OFF \
      -DCMAKE_C_FLAGS='-mcmodel=extreme -fPIC' \
      -DCMAKE_CXX_FLAGS='-mcmodel=extreme -fPIC'
  cd ..
}
function build() {
  cd build-abseil
    ninja
    ninja install
  cd ..
  source build-env/bin/activate
  cd pytorch
  rm -rf build
  CMAKE_PREFIX_PATH=$PWD/../rel-abseil/:/usr \
    BUILD_TEST=0 \
    SLEEF_BUILD_TESTS=FALSE \
    ATEN_AVX512_256=FALSE \
    BLAS=OpenBLAS \
    DEBUG=1 \
    USE_CUDA=0 \
    USE_ROCM=0 \
    CFLAGS='-D_LARGEFILE64_SOURCE -mcmodel=extreme -fPIC' \
    python setup.py develop
}
function package(){
  source build-env/bin/activate
  cd pytorch
    python setup.py bdist_wheel
    cp dist/torch-*.whl ..
  cd ..

}

function main(){
  fetch
#  prepare
#  build
#  package
}
main

