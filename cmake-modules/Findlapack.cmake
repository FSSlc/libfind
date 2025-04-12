#
# Findlapack.cmake
#
# Input:
#
#    lapack_ROOT: Root path of lapack installation
#
# Output:
#
#    lapack_FOUND: Set to true if a valid lapack is found, false otherwise
#
#  If a valid lapack is found, the following variables are set:
#
#    lapack_LIBRARIES: Libraries for lapack users.
#

if (lapack_FOUND)
  return()
endif()

if (NOT lapack_ROOT)
  set(lapack_ROOT @INSTALL_PREFIX@)
endif ()

include(LibFindMacros)

libfind_check_dependencies(lapack NAMES fortran blas REQUIRED QUIET)
libfind_check_components(lapack NAMES lapack
  PATHS ${lapack_ROOT}/lib64 ${lapack_ROOT}/lib NO_DEFAULT_PATH)

libfind_process(lapack)
