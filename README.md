# ROCm for LoongArch - rocm-loongarch

## 🇨🇳 [![简体中文](https://img.shields.io/badge/lang-中文-red.svg)](README_CN.md)

Welcome to the **rocm-loongarch** repository, a community-driven project hosted under the [loongarch-moe](https://github.com/loongarch-moe) organization. This repository contains patches and software packages for adapting the **ROCm** software stack to support GPUs on the **LoongArch** architecture. The work primarily focuses on supporting **AMDGPU** and enabling high-performance GPU computing on LoongArch.

## Project Overview

The **rocm-loongarch** project provides the following stages of adaptation for running the ROCm software stack on LoongArch-based systems:

### 1. **Kernel Stage**
   - **Enabling HSA_AMD driver support**
   - **Switching to 4KB page size**

### 2. **Stage 1 - Environment Setup**
   Basic ROCm infrastructure packages:
   - `rocm-core`
   - `rocm-llvm-core`
   - `rocm-llvm-clang`
   - `rocm-llvm-compiler-rt`
   - `rocm-llvm-lld`
   - `rocm-llvm-extra`

### 3. **Stage 2 - ROCm Management and Runtime**
   - `rocm-rocprofiler-register`
   - `rocm-rocr-runtime`
   - `rocminfo`
   - `rocm-cmake`
   - `rocm-clr`
   - `rocm_bandwidth_test`
   - `rocm-half`
   - `rocm_smi_lib`
   - `rocm-HIPIFY`
   - `rocm-rocPRIM`
   - `rocm-hipCUB`
   - `mscclpp`

### 4. **Stage 3 - Additional ROCm Dependencies**
   - `rocm-llvm-openmp`
   - `rocm-rocMLIR`
   - `rocm-llvm-mlir`
   - `rocm-llvm-flang`
   - `rocm-hipfort`
   - `rocm-rocJPEG`
   - `rocm-pgmath`
   - `rocm-flang-classic`
   - `rocm-rocDecode`

### 5. **Stage 4 - Algorithm Libraries**
   - `rocm-hipBLAS-common`
   - `rocm-hipBLASLt`
   - `rocm-rocBLAS`
   - `rocm-rocFFT`
   - `rocm-rocRAND`
   - `rocm-rccl`
   - `rocm-rocSPARSE`
   - `rocm-hipFFT`
   - `rocm-hipSPARSE`
   - `rocm-rocSOLVER`
   - `rocm-hipBLAS`
   - `rocm-hipRAND`
   - `rocm-hipSPARSELt`

### 6. **Stage 5 - Advanced Algorithm Libraries**
   - `rocm-hipSOLVER`
   - `rocm-rocThrust`
   - `rocm-rocALUTION`
   - `rocm-composable_kernel`
   - `rocm-MIOpen`
   - `rocm-ROCdbgapi`

### 7. **Stage 6 - Applications**
   - `stable-diffusion.cpp`
   - `pytorch-rocm` (in progress)
   - `pytorch-cpu`
   - `llama.cpp`
   - `cupy`
   - `aotriton`

## What is ROCm

For a detailed introduction to ROCm, including its components and architecture, you can refer to the [AMD ROCm documentation](https://rocm.docs.amd.com/en/latest/what-is-rocm.html).

## Kernel and RDNA Version Compatibility

Here is the recommended relationship between kernel versions and RDNA generations:

- **Kernel version 6.8 and above**: 4K page size support for **RDNA2/3** serial.
- **Kernel version below 6.8**: 4K/16K page size support for **RDNA2** serial.

### Default Support GPU ISA

| GPU Architecture | Shader ISA | Need PCIe Atomics? | Need HSA_OVERRIDE? |
| -- | -- | -- | -- |
| RDNA 2.0 | gfx1030 | No |  |
| RDNA 2.0 | gfx1031/2/4 | No | 10.3.0 |
| RDNA 3.0 | gfx1100/1/2 | No | |

## Releases

For the latest releases of the software and packages, please visit the [Releases page](https://github.com/loongarch-moe/rocm-loongarch/releases).

## Contributing

We welcome contributions to this project. If you're interested in improving or extending the support for ROCm on LoongArch, please feel free to fork the repository, submit issues, and create pull requests.

### Contribution Guidelines
- Ensure that your changes are well-tested and documented.
- Follow the [standard coding conventions](CONTRIBUTING.md) for ROCm and LoongArch development.

## Contact Us

For any questions or issues, feel free to open an issue in the repository, or reach out to the maintainers via GitHub Discussions.
