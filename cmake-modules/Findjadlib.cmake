#
# Findjadlib.cmake
#
# Input:
#
#    jadlib_ROOT: Root path of jadlib installation
#
# Output:
#
#    jadlib_FOUND: Set to true if a valid jadlib is found, false otherwise
#
#  If a void jadlib is found, the following variables are set:
#
#    jadlib_DEFINITIONS: Compiler definitions for jadlib users
#    jadlib_INCLUDE_DIRS: Include paths (w/o -I) for jadlib users
#    jadlib_LIBRARIES: Libraries for jadlib users.
#

if (jadlib_FOUND)
  return()
endif()

if (NOT jadlib_ROOT)
  set(jadlib_ROOT @INSTALL_PREFIX@)
endif ()

include(LibFindMacros)

libfind_check_dependencies(jadlib NAMES hdf5 mpi REQUIRED QUIET)
libfind_check_includes(jadlib NAMES jad.h jad_define.h
  PATHS ${jadlib_ROOT}/include NO_DEFAULT_PATH)
libfind_check_components(jadlib NAMES jadmpi
  PATHS ${jadlib_ROOT}/lib NO_DEFAULT_PATH)
libfind_extract_version(jadlib jad_define.h JAD_RELEASE_STR)

libfind_process(jadlib)
