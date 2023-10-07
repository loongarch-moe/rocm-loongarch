cd rocm-core
makepkg -f
makepkg -i

cd ..
cd rocm-llvm
makepkg -f
makepkg -i

cd ..
cd rocm-roct-thunk-interface
makepkg -f
makepkg -i

cd ..
cd rocm-cmake
makepkg -f
makepkg -i

cd ..
cd rocm-device-libs
makepkg -f
makepkg -i

cd ..
cd rocm-rocr-runtime
makepkg -f
makepkg -i

cd ..
cd rocminfo
makepkg -f
makepkg -i

cd ..
cd rocm-compilersupport
makepkg -f
makepkg -i

cd ..
cd rocm-clr
makepkg -f
makepkg -i

cd ..
cd rocm-rocFFT
makepkg -f
makepkg -i

# FIXME error
#cd ..
#cd rocm-rocBLAS
#makepkg -f
#makepkg -i

cd ..
cd rocm-rocPRIM
makepkg -f
makepkg -i

cd ..
cd rocm-rocRAND
makepkg -f
makepkg -i

cd ..
cd rocm-HIPIFY
makepkg -f
makepkg -i


cd ..
cd rocm-rocSPARSE
makepkg -f
makepkg -i

cd ..
cd rocm_smi_lib
makepkg -f
makepkg -i

# FIXME error
#cd ..
#cd rocm-rccl
#makepkg -f
#makepkg -i
# error
#cd ..
#cd rocm-hipSPARSE
#makepkg -f
#makepkg -i

# error `rocm-rocBLAS` `rocm-rccl` `rocm-hipSPARSE`
# error: unknown type name 'uint64_t'
# error: unknown type name 'uint32_t'
# error: no member named 'int_fast8_t' in the global namespace
# error: no member named 'int_fast16_t' in the global namespace; did you mean '__int_least16_t'?
# error: no member named 'int_fast32_t' in the global namespace; did you mean '__int_least32_t'?
# error: no member named 'int_fast64_t' in the global namespace; did you mean '__int_least64_t'?
# error: no member named 'int_least8_t' in the global namespace; did you mean '__int_least8_t'?
# error: no member named 'int_least16_t' in the global namespace; did you mean '__int_least16_t'?
# error: no member named 'int_least32_t' in the global namespace; did you mean '__int_least32_t'?
# error: no member named 'int_least64_t' in the global namespace; did you mean '__int_least64_t'
