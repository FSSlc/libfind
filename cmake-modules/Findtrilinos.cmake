#
# Findtrilinos.cmake
#
# Input:
#
#    trilinos_ROOT: Root path of trilinos installation
#
# Output:
#
#    trilinos_FOUND: Set to true if a valid trilinos is found, false otherwise
#
#  If a void trilinos is found, the following variables are set:
#
#    trilinos_DEFINITIONS: Compiler definitions for trilinos users
#    trilinos_INCLUDE_DIRS: Include paths (w/o -I) for trilinos users
#    trilinos_LIBRARIES: Libraries for trilinos users.
#

if (trilinos_FOUND)
  return()
endif()

if (NOT trilinos_ROOT)
  set(trilinos_ROOT @INSTALL_PREFIX@)
endif ()

include(LibFindMacros)

libfind_check_dependencies(trilinos NAMES umfpack parmetis mpi blas REQUIRED QUIET)
libfind_check_includes(trilinos NAMES Trilinos_version.h
  PATHS ${trilinos_ROOT}/include NO_DEFAULT_PATH)
if (NOT trilinos_FIND_COMPONENTS)
  set(trilinos_FIND_COMPONENTS aztecoo epetra epetraext triutils)
endif()
libfind_check_components(trilinos NAMES ${trilinos_FIND_COMPONENTS}
  PATHS ${trilinos_ROOT}/lib NO_DEFAULT_PATH)
libfind_extract_version(trilinos Trilinos_version.h TRILINOS_VERSION_STRING)

libfind_process(trilinos)
