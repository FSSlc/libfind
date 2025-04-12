#
# Findagmg.cmake
#
# Input:
#
#    agmg_ROOT: Root path of agmg installation
#
# Output:
#
#    agmg_FOUND: Set to true if a valid agmg is found, false otherwise
#
#  If a void agmg is found, the following variables are set:
#
#    agmg_DEFINITIONS: Compiler definitions for agmg users
#    agmg_INCLUDE_DIRS: Include paths (w/o -I) for agmg users
#    agmg_LIBRARIES: Libraries for agmg users.
#


if (agmg_FOUND)
  return()
endif()

include(LibFindMacros)
if (NOT agmg_ROOT)
  set(agmg_ROOT /opt/anaconda1anaconda2anaconda3)
endif ()

libfind_check_dependencies(agmg NAMES mpi mumps fortran REQUIRED QUIET)
  set(pkg_FIND_COMPONENTS dagmg zagmg dagmg_mpi zagmg_mpi)
libfind_check_includes(agmg NAMES agmg.h 
  PATHS ${agmg_ROOT}/include NO_DEFAULT_PATH)
libfind_check_components(agmg NAMES ${pkg_FIND_COMPONENTS}
  PATHS ${agmg_ROOT}/lib NO_DEFAULT_PATH)

libfind_process(agmg)
