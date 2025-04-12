#
# Findzitsol.cmake
#
# Input:
#
#    zitsol_ROOT: Root path of zitsol installation
#
# Output:
#
#    zitsol_FOUND: Set to true if a valid zitsol is found, false otherwise
#
#  If a void zitsol is found, the following variables are set:
#
#    zitsol_DEFINITIONS: Compiler definitions for zitsol users
#    zitsol_INCLUDE_DIRS: Include paths (w/o -I) for zitsol users
#    zitsol_LIBRARIES: Libraries for zitsol users.
#


if (zitsol_FOUND)
  return()
endif()

include(LibFindMacros)
if (NOT zitsol_ROOT)
  set(zitsol_ROOT /opt/anaconda1anaconda2anaconda3)
endif ()

libfind_check_dependencies(zitsol NAMES zlib REQUIRED QUIET)
libfind_check_includes(zitsol NAMES zdefs.h ios.h zprotos.h zheads.h
  PATHS ${zitsol_ROOT}/include NO_DEFAULT_PATH)
libfind_check_components(zitsol NAMES zitsol
  PATHS ${zitsol_ROOT}/lib64 ${zitsol_ROOT}/lib NO_DEFAULT_PATH)

libfind_process(zitsol)
