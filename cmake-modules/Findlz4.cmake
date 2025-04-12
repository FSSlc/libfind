#
# Findlz4.cmake
#
# Input:
#
#    lz4_ROOT: Root path of lz4 installation
#
# Output:
#
#    lz4_FOUND: Set to true if a valid lz4 is found, false otherwise
#
#  If a void lz4 is found, the following variables are set:
#
#    lz4_DEFINITIONS: Compiler definitions for lz4 users
#    lz4_INCLUDE_DIRS: Include paths (w/o -I) for lz4 users
#    lz4_LIBRARIES: Libraries for lz4 users.
#


if (lz4_FOUND)
  return()
endif()

include(LibFindMacros)
if (NOT lz4_ROOT)
  set(lz4_ROOT /opt/anaconda1anaconda2anaconda3)
endif ()

libfind_check_includes(lz4 NAMES lz4.h
  PATHS ${lz4_ROOT}/include NO_DEFAULT_PATH)
libfind_check_components(lz4 NAMES lz4 
  PATHS ${lz4_ROOT}/lib NO_DEFAULT_PATH)
libfind_extract_version(lz4 lz4.h LZ4_VERSION_MAJOR LZ4_VERSION_MINOR LZ4_VERSION_RELEASE AS_INTS)

libfind_process(lz4)
