#//////////////////////////////////////////////////////////////////////////////
#   -- MAGMA (version 2.0) --
#      Univ. of Tennessee, Knoxville
#      Univ. of California, Berkeley
#      Univ. of Colorado, Denver
#      @date
#//////////////////////////////////////////////////////////////////////////////

# --------------------
# MAGMA configuration: HIP, GCC, MKL

# -*-
# Most things here are similar to CUDA, and this script is designed to build
#   with CUDA and without HIP (by setting BACKEND=cuda).

# -*-
# If there are any problems building with this new HIP setup specifically,
#   you can email Cade Brown <cbrow216@vols.utk.edu> with your issues

# -*-
# note: when creating an application on top of hipMAGMA, you may need to use
#   the HIP compiler (or some C++) compiler, even if your application is
#   expecting the C interface of MAGMA. This is due to the way HIP defines
#   its types as C++ types. So, you can replace `CC=gcc` with `CC=hipcc`,
#   and your project should compile fine.


# --------------------
# configuration

# should MAGMA be built on CUDA (NVIDIA only) or HIP (AMD or NVIDIA)
# enter 'cuda' or 'hip' respectively
BACKEND      = hip

# set these to their real paths
HIPDIR      ?= /opt/rocm/hip

# require either hip or cuda
ifeq (,$(findstring $(BACKEND),hip cuda))
    $(error "'BACKEND' should be either 'cuda' or 'hip' (got $$BACKEND=$(BACKEND))")
endif

# --------------------
# programs

# set compilers
# NOTE: CC & CXX need to be a HIP compiler
CC           = hipcc
CXX          = hipcc
FORT        ?= gfortran
HIPCC       ?= hipcc
NVCC        ?= nvcc
DEVCC       ?= NONE

# set from 'BACKEND'
ifeq ($(BACKEND),cuda)
    DEVCC    = $(NVCC)
else ifeq ($(BACKEND),hip)
    DEVCC    = $(HIPCC)
endif

# and utilities
ARCH        ?= ar
ARCHFLAGS   ?= cr
RANLIB      ?= ranlib


# --------------------
# flags/settings

# set our GPU targets
ifeq ($(BACKEND),cuda)
    # See a full table: https://nouveau.freedesktop.org/wiki/CodeNames/
    # note: provided by freedesktop, which is reliable, but not from the vendor
    GPU_TARGET ?= Maxwell Pascal Volta Turing
else ifeq ($(BACKEND),hip)
    # See a full table: 
    #   https://llvm.org/docs/AMDGPUUsage.html#amdgpu-processor-table
    # note: provided by LLVM, so not technically from the vendor.
    # Here's ROCm's source: https://rocm.github.io/hardware.html , but it is 
    # not specific enough. TODO: find better link?
    GPU_TARGET ?= gfx900 gfx906 gfx908
endif

# Use -fPIC to make shared (.so) and static (.a) library;
# can be commented out if making only static library.
FPIC        = -fPIC

# use -fopenmp to support openmp builds
# comment out to build without openmp support
# NOTE: For some reason, using `-fopenmp` is not enough to add linker flags to 
#   the compiler sometimes, so we need to add -L here too if there are problems
#FOPENMP     = -fopenmp
#FOPENMP     = 
#FOPENMP     = -fopenmp -L$(HIPDIR)/../aomp/lib -I$(HIPDIR)/../aomp/include

# now, generate our flags
CFLAGS      = -O3 $(FPIC) $(FOPENMP) -DNDEBUG -DADD_ -Wall -std=c99
CXXFLAGS    = -O3 $(FPIC) $(FOPENMP) -DNDEBUG -DADD_ -Wall -std=c++11
FFLAGS      = -O3 $(FPIC) -DNDEBUG -DADD_ -Wall -Wno-unused-dummy-argument
F90FLAGS    = -O3 $(FPIC) -DNDEBUG -DADD_ -Wall -Wno-unused-dummy-argument -x f95-cpp-input
LDFLAGS     =     $(FPIC) $(FOPENMP)        

# add in the default for device compiling
DEVCCFLAGS  = -O3 -DNDEBUG -DADD_ 

# add the flags in a backend-specific way
ifeq ($(BACKEND),cuda)
    DEVCCFLAGS += -Xcompiler "$(FPIC)" -Xcompiler "$(FOPENMP)" -std=c++11
else ifeq ($(BACKEND),hip)
    DEVCCFLAGS += $(FPIC) $(FOPENMP) -std=c++11
    # check for older versions of HIP
    ifeq ($(shell hipconfig --version | cut -b -3),3.0)
        $(info Building with HIP 3.0)
        # they don't have hipblasComplex yet, so replace it manually
        DEVCCFLAGS += -DhipblasComplex=hipComplex -DhipblasDoubleComplex=hipDoubleComplex
    endif
    
    # add in linker flags
    LDFLAGS += -L$(HIPDIR)/lib -L$(HIPDIR)/../aomp/lib -L$(HIPDIR)/../hipblas/lib -L$(HIPDIR)/../hipsparse/lib
    CXXFLAGS += -I$(HIPDIR)/include
endif


# --------------------
# libraries

LIB       = -lpthread -lm
ifeq ($(BACKEND),cuda)
    LIB   += -lcublas -lcusparse -lcudart -lcudadevrt
else ifeq ($(BACKEND),hip)
    # TODO: see if we will need to link anything
    LIB   += -lhipblas -lhipsparse 
endif

# --------------------
# directories

# define library directories preferably in your environment, or here.
LIBDIR    += -L$(HIPDIR)/../hipblas/lib -L$(HIPDIR)/../hipsparse/lib -L$(MKLROOT)/lib/intel64
# define include directories (like -I/path/to/dir) in your env, or here.
INC       += -I$(HIPDIR)/../hipblas/include -I$(HIPDIR)/../hipsparse/include -I$(MKLROOT)/include

# include each's directories
# note: we don't need to include the library directories, since nvcc or hipcc 
#   should already know about them. But, `gcc` might not know about include 
#   folders
ifeq ($(BACKEND),cuda)
    INC   += -I$(CUDADIR)/include
else ifeq ($(BACKEND),hip)
    INC   += -I$(HIPDIR)/include
endif


# --------------------
# checks

# checks for the specified backend
ifeq ($(BACKEND),cuda)
    -include make.check-cuda
else ifeq ($(BACKEND),hip)
    -include make.check-hip
endif

LIB += -Wl,--enable-new-dtags -Wl,--rpath,/opt/rocm-6.3.3/lib -Wl,--rpath,/opt/rocm-6.3.3/lib64 -Wl,--rpath,/opt/rocm-6.3.3/magma/lib
LIB += $(EXT_CFLAGS)
DEVCCFLAGS += $(EXT_CFLAGS)
CXXFLAGS += $(EXT_CFLAGS)
DEVCCFLAGS += --gpu-max-threads-per-block=256
DEVCCFLAGS += --offload-arch=gfx900
DEVCCFLAGS += --offload-arch=gfx1010
DEVCCFLAGS += --offload-arch=gfx1012
DEVCCFLAGS += --offload-arch=gfx1030
DEVCCFLAGS += --offload-arch=gfx1100
DEVCCFLAGS += --offload-arch=gfx1101
DEVCCFLAGS += --offload-arch=gfx1102
DEVCCFLAGS += --offload-arch=gfx1200
DEVCCFLAGS += --offload-arch=gfx1201
