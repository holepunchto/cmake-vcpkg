include_guard()

set(vcpkg_module_dir "${CMAKE_CURRENT_LIST_DIR}")

if(NOT DEFINED ENV{VCPKG_ROOT})
  message(
    FATAL_ERROR
    "The VCPKG_ROOT environment variable must be set. See "
    "https://learn.microsoft.com/en-us/vcpkg/users/config-environment#vcpkg_root"
  )
endif()

set(VCPKG_OVERLAY_TRIPLETS "${vcpkg_module_dir}/triplets")
set(VCPKG_INSTALLED_DIR ${CMAKE_BINARY_DIR}/_vcpkg)

# Set the original CMake toolchain file as a cache variable to avoid include()
# recursion when the build system is regenerated.
set(VCPKG_CMAKE_TOOLCHAIN_FILE "${CMAKE_TOOLCHAIN_FILE}" CACHE PATH "The CMake toolchain file")

# Chainload the original CMake toolchain file to ensure that it still defines
# the compiler toolchain to use.
set(VCPKG_CHAINLOAD_TOOLCHAIN_FILE "${VCPKG_CMAKE_TOOLCHAIN_FILE}")

# Replace the original CMake toolchain file with the vcpkg toolchain.
set(CMAKE_TOOLCHAIN_FILE "$ENV{VCPKG_ROOT}/scripts/buildsystems/vcpkg.cmake")
