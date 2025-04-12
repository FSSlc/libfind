#
# Findsuperlu_dist.cmake
#
# Input:
#
#    superlu_dist_ROOT: Root path of superlu_dist installation
#
# Output:
#
#    superlu_dist_FOUND: Set to true if a valid superlu_dist is found, false otherwise
#
#  If a void superlu_dist is found, the following variables are set:
#
#    superlu_dist_DEFINITIONS: Compiler definitions for superlu_dist users
#    superlu_dist_INCLUDE_DIRS: Include paths (w/o -I) for superlu_dist users
#    superlu_dist_LIBRARIES: Libraries for superlu_dist users.
#

if (superlu_dist_FOUND)
  return()
endif()

if (NOT superlu_dist_ROOT)
  set(superlu_dist_ROOT @INSTALL_PREFIX@)
endif ()

include(LibFindMacros)

libfind_check_dependencies(superlu_dist NAMES mpi metis parmetis blas
  REQUIRED QUIET)
libfind_check_includes(superlu_dist NAMES superlu_dist_config.h superlu_defs.h
  PATHS ${superlu_dist_ROOT}/include NO_DEFAULT_PATH)
libfind_check_components(superlu_dist NAMES superlu_dist
  PATHS ${superlu_dist_ROOT}/lib64 ${superlu_dist_ROOT}/lib NO_DEFAULT_PATH)
libfind_extract_version(superlu_dist superlu_defs.h SUPERLU_DIST_MAJOR_VERSION 
  SUPERLU_DIST_MINOR_VERSION SUPERLU_DIST_PATCH_VERSION AS_INTS)

libfind_process(superlu_dist)
