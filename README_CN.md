# ROCm for LoongArch - rocm-loongarch

欢迎来到**Rocm-loongarch**存储库，这是一个由[loongarch-moe](https://github.com/loongarch-moe) 组织下的社区驱动项目。该存储库包含补丁程序和软件包，用于调整**ROCM**软件堆栈以支持**LoongArch**体系结构上的GPU。这项工作主要侧重于支持**AMDGPU**，并在**LoongArch**上启用高性能GPU计算。

## 项目概述

**rocm-loongarch** 项目提供了以下适配阶段，以便在基于 LoongArch 的系统上运行 ROCm 软件栈：

### 1. **Kernel 阶段**
   - **开启 HSA_AMD 驱动支持**
   - **切换到 4KB 页大小**

### 2. **Stage 1 - 环境基础**
   基础 ROCm 环境包:
   - `rocm-core`
   - `rocm-llvm-core`
   - `rocm-llvm-clang`
   - `rocm-llvm-compiler-rt`
   - `rocm-llvm-lld`
   - `rocm-llvm-extra`

### 3. **Stage 2 - ROCm 管理包与运行时**
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

### 4. **Stage 3 - 额外的 ROCm 依赖项**
   - `rocm-llvm-openmp`
   - `rocm-rocMLIR`
   - `rocm-llvm-mlir`
   - `rocm-llvm-flang`
   - `rocm-hipfort`
   - `rocm-rocJPEG`
   - `rocm-pgmath`
   - `rocm-flang-classic`
   - `rocm-rocDecode`

### 5. **Stage 4 - 算法库**
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

### 6. **Stage 5 - 高级算法库**
   - `rocm-hipSOLVER`
   - `rocm-rocThrust`
   - `rocm-rocALUTION`
   - `rocm-composable_kernel`
   - `rocm-MIOpen`
   - `rocm-ROCdbgapi`

### 7. **Stage 6 - 应用程序**
   - `stable-diffusion.cpp`
   - `pytorch-rocm` (适配中)
   - `pytorch-cpu`
   - `llama.cpp`
   - `cupy`
   - `aotriton`

## ROCm 介绍
ROCm 介绍的详细信息，包括它的组件和架构，可以参考 [AMD ROCm 文档](https://rocm.docs.amd.com/en/latest/what-is-rocm.html)。

## 内核与 RDNA 版本的兼容性
以下是建议：
- **内核版本 6.8 及以上 + 4KB 页大小**：支持 **RDNA2/3** 系列
- **内核版本 6.8 以下 + 4KB/16KB页大小**：支持 **RDNA2** 系列

### 项目开启的GPU ISA版本

| GPU Architecture | Shader ISA | Need PCIe Atomics? | Need HSA_OVERRIDE? |
| -- | -- | -- | -- |
| RDNA 2.0 | gfx1030 | No |  |
| RDNA 2.0 | gfx1031/2/4 | No | 10.3.0 |
| RDNA 3.0 | gfx1100/1/2 | No | |

## Releases

有关软件包的最新版本，请访问 [Releases 页面](https://github.com/loongarch-moe/rocm-loongarch/releases)。

## 贡献

我们欢迎大家为这个项目贡献代码。如果你有兴趣改进或扩展在 LoongArch 上的 ROCm 支持，请随时叉出这个仓库，提交问题，或创建拉取请求。

### 贡献指南
- 请确保您的更改是经过充分测试并且有良好文档支持的。
- 请遵循 ROCm 和 LoongArch 开发的 [标准编码规范](CONTRIBUTING.md)。

## 联系我们

如果有任何问题或建议，请随时在仓库中打开 issue，或通过 GitHub Discussions 与维护者联系。
