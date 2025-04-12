#
# Findhwloc.cmake
#
# Input:
#
#    hwloc_ROOT: Root path of hwloc installation
#
# Output:
#
#    hwloc_FOUND: Set to true if a valid hwloc is found, false otherwise
#
#  If a void hwloc is found, the following variables are set:
#
#    hwloc_DEFINITIONS: Compiler definitions for hwloc users
#    hwloc_INCLUDE_DIRS: Include paths (w/o -I) for hwloc users
#    hwloc_LIBRARIES: Libraries for hwloc users.
#


if (hwloc_FOUND)
  return()
endif()

include(LibFindMacros)
if (NOT hwloc_ROOT)
  set(hwloc_ROOT /opt/anaconda1anaconda2anaconda3)
endif ()

set(tmp $ENV{PKG_CONFIG_PATH})
set(ENV{PKG_CONFIG_PATH} ${hwloc_ROOT}/lib/pkgconfig)
libfind_check_pkgconfig(hwloc hwloc)
set(ENV{PKG_CONFIG_PATH} ${tmp})

libfind_process(hwloc)
