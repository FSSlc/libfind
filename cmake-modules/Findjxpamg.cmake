#
# Findjxpamg.cmake
#
# Input:
#
#    jxpamg_ROOT: Root path of jxpamg installation
#
# Output:
#
#    jxpamg_FOUND: Set to true if a valid jxpamg is found, false otherwise
#
#  If a void jxpamg is found, the following variables are set:
#
#    jxpamg_DEFINITIONS: Compiler definitions for jxpamg users
#    jxpamg_INCLUDE_DIRS: Include paths (w/o -I) for jxpamg users
#    jxpamg_LIBRARIES: Libraries for jxpamg users.
#


if(jxpamg_FOUND)
  return()
endif()

include(LibFindMacros)
if(NOT jxpamg_ROOT)
  set(jxpamg_ROOT /opt/anaconda1anaconda2anaconda3)
endif()
libfind_check_dependencies(jxpamg NAMES mpi openmp REQUIRED)
libfind_check_includes(jxpamg NAMES jx_pamg.h
  PATHS ${jxpamg_ROOT}/include NO_DEFAULT_PATH)
libfind_check_components(jxpamg NAMES JXPAMG
  PATHS ${jxpamg_ROOT}/lib NO_DEFAULT_PATH)

libfind_process(jxpamg)
