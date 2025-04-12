#
# Findiconv.cmake
#
# Input:
#
#    iconv_ROOT: Root path of iconv installation
#
# Output:
#
#    iconv_FOUND: Set to true if a valid iconv is found, false otherwise
#
# If a valid iconv is found, the following variables are set:
#
#    iconv_DEFINITIONS: Compiler definitions for iconv users
#    iconv_INCLUDE_DIRS: Include paths (w/o -I) for iconv users
#    iconv_LIBRARIES: Libraries for iconv users.
#


if (iconv_FOUND)
  return()
endif()

include(LibFindMacros)
if (NOT iconv_ROOT)
  set(iconv_ROOT /opt/anaconda1anaconda2anaconda3)
endif()

libfind_check_includes(iconv NAMES iconv.h PATHS ${iconv_ROOT}/include NO_DEFAULT_PATH)
libfind_check_components(iconv NAMES iconv PATHS ${iconv_ROOT}/lib64 ${iconv_ROOT}/lib NO_DEFAULT_PATH)

libfind_process(iconv)
