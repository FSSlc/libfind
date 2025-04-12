#
# Findzoltan.cmake
#
# Input:
#
#    zoltan_ROOT: Root path of zoltan installation
#
# Output:
#
#    zoltan_FOUND: Set to true if a valid zoltan is found, false otherwise
#
#  If a void zoltan is found, the following variables are set:
#
#    zoltan_DEFINITIONS: Compiler definitions for zoltan users
#    zoltan_INCLUDE_DIRS: Include paths (w/o -I) for zoltan users
#    zoltan_LIBRARIES: Libraries for zoltan users.
#


if (zoltan_FOUND)
  return()
endif()

include(LibFindMacros)
if (NOT zoltan_ROOT)
  set(zoltan_ROOT /opt/anaconda1anaconda2anaconda3)
endif ()

libfind_check_dependencies(zoltan NAMES mpi REQUIRED QUIET)
libfind_check_includes(zoltan NAMES zoltan.h
  PATHS ${zoltan_ROOT}/include NO_DEFAULT_PATH)
libfind_check_components(zoltan NAMES zoltan
  PATHS ${zoltan_ROOT}/lib NO_DEFAULT_PATH)
libfind_extract_version(zoltan zoltan.h ZOLTAN_VERSION_NUMBER AS_INTS)

libfind_process(zoltan)
