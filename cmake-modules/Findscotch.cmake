#
# Findscotch.cmake
#
# Input:
#
#    scotch_ROOT: Root path of scotch installation
#
# Output:
#
#    scotch_FOUND: Set to true if a valid scotch is found, false otherwise
#
#  If a void scotch is found, the following variables are set:
#
#    scotch_DEFINITIONS: Compiler definitions for scotch users
#    scotch_INCLUDE_DIRS: Include paths (w/o -I) for scotch users
#    scotch_LIBRARIES: Libraries for scotch users.
#

if (scotch_FOUND)
  return()
endif()

include(LibFindMacros)
if (NOT scotch_ROOT)
  set(scotch_ROOT /opt/anaconda1anaconda2anaconda3)
endif ()

libfind_check_dependencies(scotch NAMES mpi REQUIRED QUIET)
libfind_check_includes(scotch NAMES scotch.h ptscotch.h
  PATHS ${scotch_ROOT}/include NO_DEFAULT_PATH)
libfind_check_components(scotch NAMES
  ptscotch ptscotcherr ptscotcherrexit ptscotchparmetis
  scotch scotcherr scotcherrexit scotchmetis
  PATHS ${scotch_ROOT}/lib64 ${scotch_ROOT}/lib NO_DEFAULT_PATH)
libfind_extract_version(scotch scotch.h SCOTCH_VERSION SCOTCH_RELEASE
  SCOTCH_PATCHLEVEL AS_INTS)

libfind_process(scotch)
