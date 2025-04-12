#
# Findszlib.cmake
#
# Input:
#
#    szlib_ROOT: Root path of szlib installation
#
# Output:
#
#    szlib_FOUND: Set to true if a valid szlib is found, false otherwise
#
#  If a void szlib is found, the following variables are set:
#
#    szlib_DEFINITIONS: Compiler definitions for szlib users
#    szlib_INCLUDE_DIRS: Include paths (w/o -I) for szlib users
#    szlib_LIBRARIES: Libraries for szlib users.
#


if (szlib_FOUND)
  return()
endif()

include(LibFindMacros)
if (NOT szlib_ROOT)
  set(szlib_ROOT /opt/anaconda1anaconda2anaconda3)
endif ()

libfind_check_includes(szlib NAMES szlib.h
  PATHS ${szlib_ROOT}/include NO_DEFAULT_PATH)
libfind_check_components(szlib NAMES sz 
  PATHS ${szlib_ROOT}/lib64 ${szlib_ROOT}/lib NO_DEFAULT_PATH)
libfind_extract_version(szlib szlib.h SZLIB_VERSION AS_INTS)

libfind_process(szlib)
