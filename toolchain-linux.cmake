#set(CMAKE_MAKE_PROGRAM "nmake.exe")
#set(CMAKE_GENERATOR "Ninja")
# Ninja doesn't support platform
#set(CMAKE_GENERATOR_PLATFORM x64)

if (DEFINED ENV{ROCM_PATH})
  set(rocm_bin "$ENV{ROCM_PATH}/bin")
else()
  set(ROCM_PATH "/opt/rocm" CACHE PATH "Path to the ROCm installation.")
  set(rocm_bin "/opt/rocm/bin")
endif()

if (NOT DEFINED ENV{CXX})
  set(CMAKE_CXX_COMPILER "${rocm_bin}/amdclang++" CACHE PATH "Path to the C++ compiler")
  set(CMAKE_CXX_FLAGS_INIT "-mllvm -amdgpu-early-inline-all=true -mllvm -amdgpu-function-calls=false")
  if (DEFINED ENV{HIPCC_COMPILE_FLAGS_APPEND})
    set(CMAKE_CXX_FLAGS_INIT "${CMAKE_CXX_FLAGS_INIT} $ENV{HIPCC_COMPILE_FLAGS_APPEND}")
  endif()
else()
  set(CMAKE_CXX_COMPILER "$ENV{CXX}" CACHE PATH "Path to the C++ compiler")
endif()

if (NOT DEFINED ENV{CC})
  set(CMAKE_C_COMPILER "${rocm_bin}/amdclang" CACHE PATH "Path to the C compiler")
  set(CMAKE_C_FLAGS_INIT "-mllvm -amdgpu-early-inline-all=true -mllvm -amdgpu-function-calls=false")
  if (DEFINED ENV{HIPCC_COMPILE_FLAGS_APPEND})
    set(CMAKE_C_FLAGS_INIT "${CMAKE_C_FLAGS_INIT} $ENV{HIPCC_COMPILE_FLAGS_APPEND}")
  endif()
else()
  set(CMAKE_C_COMPILER "$ENV{CC}" CACHE PATH "Path to the C compiler")
endif()
