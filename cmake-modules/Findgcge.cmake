#
# Findgcge.cmake
#
# Input:
#
#    gcge_ROOT: Root path of gcge installation
#
# Output:
#
#    gcge_FOUND: Set to true if a valid gcge is found, false otherwise
#
#  If a void gcge is found, the following variables are set:
#
#    gcge_DEFINITIONS: Compiler definitions for gcge users
#    gcge_INCLUDE_DIRS: Include paths (w/o -I) for gcge users
#    gcge_LIBRARIES: Libraries for gcge users.
#


if (gcge_FOUND)
  return()
endif()

include(LibFindMacros)
if (NOT gcge_ROOT)
  set(gcge_ROOT /opt/anaconda1anaconda2anaconda3)
endif ()

libfind_check_dependencies(gcge NAMES mpi metis petsc slepc mumps superlu_dist REQUIRED QUIET)

libfind_check_includes(gcge NAMES ops_eig_sol_gcg.h PATHS ${gcge_ROOT}/include NO_DEFAULT_PATH)

libfind_check_components(gcge NAMES GCGE PATHS ${gcge_ROOT}/lib NO_DEFAULT_PATH)

libfind_process(gcge)
