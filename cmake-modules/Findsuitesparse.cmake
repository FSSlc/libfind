#
# Findsuitesparse.cmake
#
# Input:
#
#    suitesparse_ROOT: Root path of suitesparse installation
#
# Output:
#
#    suitesparse_FOUND: Set to true if a valid suitesparse is found, false otherwise
#
#  If a void suitesparse is found, the following variables are set:
#
#    suitesparse_DEFINITIONS: Compiler definitions for suitesparse users
#    suitesparse_INCLUDE_DIRS: Include paths (w/o -I) for suitesparse users
#    suitesparse_LIBRARIES: Libraries for suitesparse users.
#

if (suitesparse_FOUND)
  return()
endif()

if (NOT suitesparse_ROOT)
  set(suitesparse_ROOT @INSTALL_PREFIX@)
endif ()

include(LibFindMacros)

libfind_check_dependencies(suitesparse NAMES openmp blas metis REQUIRED QUIET)
libfind_check_includes(suitesparse NAMES SuiteSparse_config.h
  PATHS ${suitesparse_ROOT}/include NO_DEFAULT_PATH)
if (NOT suitesparse_FIND_COMPONENTS)
  set(suitesparse_FIND_COMPONENTS umfpack cholmod klu ccolamd camd colamd amd
    rbio cxsparse csparse spqr btf ldl suitesparseconfig)
endif()
libfind_check_components(suitesparse NAMES ${suitesparse_FIND_COMPONENTS}
  PATHS ${suitesparse_ROOT}/lib NO_DEFAULT_PATH)
libfind_extract_version(suitesparse SuiteSparse_config.h
  SUITESPARSE_MAIN_VERSION SUITESPARSE_SUB_VERSION
  SUITESPARSE_SUBSUB_VERSION AS_INTS)

libfind_process(suitesparse GROUP_COMPONENTS)
