#
# Findscalapack.cmake
#
# Input:
#
#    scalapack_ROOT: Root path of scalapack installation
#
# Output:
#
#    scalapack_FOUND: Set to true if a valid scalapack is found, false otherwise
#
#  If a void scalapack is found, the following variables are set:
#
#    scalapack_DEFINITIONS: Compiler definitions for scalapack users
#    scalapack_INCLUDE_DIRS: Include paths (w/o -I) for scalapack users
#    scalapack_LIBRARIES: Libraries for scalapack users.
#


if (scalapack_FOUND)
  return()
endif()

include(LibFindMacros)
if (NOT scalapack_ROOT)
  set(scalapack_ROOT /opt/anaconda1anaconda2anaconda3)
endif ()

libfind_check_dependencies(scalapack NAMES mpi lapack openblas REQUIRED QUIET)
libfind_check_components(scalapack NAMES scalapack
  PATHS ${scalapack_ROOT}/lib NO_DEFAULT_PATH)

libfind_process(scalapack)
