#
# Findslepc.cmake
#
# Input:
#
#    slepc_ROOT: Root path of slepc installation
#
# Output:
#
#    slepc_FOUND: Set to true if a valid slepc is found, false otherwise
#
#  If a void slepc is found, the following variables are set:
#
#    slepc_DEFINITIONS: Compiler definitions for slepc users
#    slepc_INCLUDE_DIRS: Include paths (w/o -I) for slepc users
#    slepc_LIBRARIES: Libraries for slepc users.
#

if (slepc_FOUND)
  return()
endif()

if (NOT slepc_ROOT)
  set(slepc_ROOT @INSTALL_PREFIX@)
endif ()

set(allowed_slepc_libtypes real complex all)
if (NOT slepc_LIBTYPE)
  set(slepc_LIBTYPE "real")
elseif (NOT slepc_LIBTYPE IN_LIST allowed_slepc_libtypes)
  message(FATAL_ERROR "Invalid slepc_LIBTYPE '${slepc_LIBTYPE}', only real,"
    "complex or all is allowed")
elseif (slepc_LIBTYPE STREQUAL "all")
  set(petsc_LIBTYPE all)
  set(slepc_LIBTYPE real complex)
else()
  set(petsc_LIBTYPE ${slepc_LIBTYPE})
endif()

include(LibFindMacros)

libfind_check_dependencies(slepc NAMES petsc arpack REQUIRED QUIET)
libfind_check_includes(slepc NAMES slepc.h slepcversion.h
  PATHS ${slepc_ROOT}/include NO_DEFAULT_PATH)
if (NOT slepc_FIND_COMPONENTS)
  foreach (item ${slepc_LIBTYPE})
    list(APPEND slepc_FIND_COMPONENTS slepc-${item})
  endforeach()
endif()
libfind_check_components(slepc NAMES ${slepc_FIND_COMPONENTS}
  PATHS ${slepc_ROOT}/lib NO_DEFAULT_PATH)
libfind_extract_version(slepc slepcversion.h SLEPC_VERSION_MAJOR
  SLEPC_VERSION_MINOR SLEPC_VERSION_SUBMINOR AS_INTS)

libfind_process(slepc)
