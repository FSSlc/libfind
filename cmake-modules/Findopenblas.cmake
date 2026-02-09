#
# Findopenblas.cmake
#
# Input:
#
#    openblas_ROOT: Root path of openblas installation
#
# Output:
#
#    openblas_FOUND: Set to true if a valid openblas is found, false otherwise
#
#  If a void openblas is found, the following variables are set:
#
#    openblas_LIBRARIES: Libraries for openblas users.
#


if (openblas_FOUND)
  return()
endif()

include(LibFindMacros)
if (NOT openblas_ROOT)
  set(openblas_ROOT /opt/anaconda1anaconda2anaconda3)
endif ()


libfind_check_dependencies(openblas NAMES fortran REQUIRED QUIET)
libfind_check_components(openblas NAMES openblas
  PATHS ${openblas_ROOT}/lib64 ${openblas_ROOT}/lib NO_DEFAULT_PATH)

libfind_process(openblas)
