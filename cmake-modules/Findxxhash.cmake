#
# Findxxhash.cmake
#
# Input:
#
#    xxhash_ROOT: Root path of xxhash installation
#
# Output:
#
#    xxhash_FOUND: Set to true if a valid xxhash is found, false otherwise
#
#  If a void xxhash is found, the following variables are set:
#
#    xxhash_INCLUDE_DIRS: Include paths (w/o -I) for xxhash users
#


if (xxhash_FOUND)
  return()
endif()

include(LibFindMacros)
if (NOT xxhash_ROOT)
  set(xxhash_ROOT /opt/anaconda1anaconda2anaconda3)
endif ()

libfind_check_includes(xxhash NAMES xxhash64.h
  PATHS ${xxhash_ROOT}/include NO_DEFAULT_PATH)

libfind_process(xxhash)
