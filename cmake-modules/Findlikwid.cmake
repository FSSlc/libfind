#
# Findlikwid.cmake
#
# Input:
#
#    likwid_ROOT: Root path of likwid installation
#
# Output:
#
#    likwid_FOUND: Set to true if a valid likwid is found, false otherwise
#
#  If a void likwid is found, the following variables are set:
#
#    likwid_DEFINITIONS: Compiler definitions for likwid users
#    likwid_INCLUDE_DIRS: Include paths (w/o -I) for likwid users
#    likwid_LIBRARIES: Libraries for likwid users.
#


if (likwid_FOUND)
  return()
endif()

include(LibFindMacros)
if (NOT likwid_ROOT)
  set(likwid_ROOT /opt/anaconda1anaconda2anaconda3)
endif ()

libfind_check_includes(likwid NAMES likwid.h
  PATHS ${likwid_ROOT}/include NO_DEFAULT_PATH)
libfind_check_components(likwid NAMES likwid likwid-hwloc likwid-lua
  PATHS ${likwid_ROOT}/lib NO_DEFAULT_PATH)

libfind_process(likwid)
