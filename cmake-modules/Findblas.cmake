#
# Findblas.cmake
#
# Input:
#
#    blas_ROOT: Root path of blas installation
#
# Output:
#
#    blas_FOUND: Set to true if a valid blas is found, false otherwise
#
#  If a void blas is found, the following variables are set:
#
#    blas_LIBRARIES: Libraries for blas users.
#

if (blas_FOUND)
  return()
endif()

if (NOT blas_ROOT)
  set(blas_ROOT @INSTALL_PREFIX@)
endif ()

include(LibFindMacros)

libfind_check_dependencies(blas NAMES fortran REQUIRED QUIET)
libfind_check_components(blas NAMES blas
  PATHS ${blas_ROOT}/lib64 ${blas_ROOT}/lib NO_DEFAULT_PATH)

libfind_process(blas)
