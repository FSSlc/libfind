#
# Findarpack.cmake
#
# Input:
#
#    arpack_ROOT: Root path of arpack installation
#
# Output:
#
#    arpack_FOUND: Set to true if a valid arpack is found, false otherwise
#
#  If a void arpack is found, the following variables are set:
#
#    arpack_DEFINITIONS: Compiler definitions for arpack users
#    arpack_INCLUDE_DIRS: Include paths (w/o -I) for arpack users
#    arpack_LIBRARIES: Libraries for arpack users.
#

if (arpack_FOUND)
  return()
endif()

include(LibFindMacros)
if (NOT arpack_ROOT)
  set(arpack_ROOT /opt/anaconda1anaconda2anaconda3)
endif ()

libfind_check_dependencies(arpack NAMES mpi REQUIRED QUIET)
libfind_check_components(arpack NAMES parpack arpack
  PATHS ${arpack_ROOT}/lib NO_DEFAULT_PATH)

libfind_process(arpack)
