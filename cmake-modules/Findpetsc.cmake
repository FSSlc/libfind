#
# Findpetsc.cmake
#
# Input:
#
#    petsc_ROOT: Root path of petsc installation
#
# Output:
#
#    petsc_FOUND: Set to true if a valid petsc is found, false otherwise
#
#  If a void petsc is found, the following variables are set:
#
#    petsc_DEFINITIONS: Compiler definitions for petsc users
#    petsc_INCLUDE_DIRS: Include paths (w/o -I) for petsc users
#    petsc_LIBRARIES: Libraries for petsc users.
#

if (petsc_FOUND)
  return()
endif()

if (NOT petsc_ROOT)
  set(petsc_ROOT @INSTALL_PREFIX@)
endif ()

set(allowed_petsc_libtypes real complex all)
if (NOT petsc_LIBTYPE)
  set(petsc_LIBTYPE "real")
elseif (NOT petsc_LIBTYPE IN_LIST allowed_petsc_libtypes)
  message(FATAL_ERROR "Invalid petsc_LIBTYPE '${petsc_LIBTYPE}', only real,"
    "complex or all is allowed")
elseif (petsc_LIBTYPE STREQUAL "all")
  set(petsc_LIBTYPE real complex)
endif()

include(LibFindMacros)

libfind_check_dependencies(petsc NAMES mpi openmp parmetis metis scalapack
  superlu_dist mumps REQUIRED QUIET)
libfind_check_includes(petsc NAMES petsc.h petscversion.h
  PATHS ${petsc_ROOT}/include NO_DEFAULT_PATH)
if (NOT petsc_FIND_COMPONENTS)
  foreach (item ${petsc_LIBTYPE})
    list(APPEND petsc_FIND_COMPONENTS petsc-${item})
  endforeach()
endif()
libfind_check_components(petsc NAMES ${petsc_FIND_COMPONENTS}
  PATHS ${petsc_ROOT}/lib NO_DEFAULT_PATH)
libfind_extract_version(petsc petscversion.h PETSC_VERSION_MAJOR
  PETSC_VERSION_MINOR PETSC_VERSION_SUBMINOR AS_INTS)

libfind_process(petsc)
