#
# Findjropet.cmake
#
# Input:
#
#    jropet_ROOT: Root path of jropet installation
#
# Output:
#
#    jropet_FOUND: Set to true if a valid jropet is found, false otherwise
#
#  If a void jropet is found, the following variables are set:
#
#    jropet_DEFINITIONS: Compiler definitions for jropet users
#    jropet_INCLUDE_DIRS: Include paths (w/o -I) for jropet users
#    jropet_LIBRARIES: Libraries for jropet users.
#


if (jropet_FOUND)
  return()
endif()

include(LibFindMacros)
if (NOT jropet_ROOT)
  set(jropet_ROOT /opt/anaconda1anaconda2anaconda3)
endif ()

libfind_check_dependencies(jropet NAMES mpi REQUIRED QUIET)
libfind_check_includes(jropet NAMES jropet/jarena.h
  PATHS ${jropet_ROOT}/include NO_DEFAULT_PATH)
libfind_check_components(jropet NAMES jarena numa_model
  PATHS ${jropet_ROOT}/lib NO_DEFAULT_PATH)

libfind_process(jropet)
