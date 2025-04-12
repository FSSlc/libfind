#
# Findgmp.cmake
#
# Input:
#
#    gmp_ROOT: Root path of gmp installation
#
# Output:
#
#    gmp_FOUND: Set to true if a valid gmp is found, false otherwise
#
# If a valid gmp is found, the following variables are set:
#
#    gmp_DEFINITIONS: Compiler definitions for gmp users
#    gmp_INCLUDE_DIRS: Include paths (w/o -I) for gmp users
#    gmp_LIBRARIES: Libraries for gmp users.
#

if (gmp_FOUND)
  return()
endif()

if (NOT gmp_ROOT)
  set(gmp_ROOT @INSTALL_PREFIX@)
endif()

include(LibFindMacros)

libfind_check_includes(gmp NAMES gmp.h gmpxx.h PATHS ${gmp_ROOT}/include NO_DEFAULT_PATH)
libfind_check_components(gmp NAMES gmp gmpxx PATHS ${gmp_ROOT}/lib64 ${gmp_ROOT}/lib NO_DEFAULT_PATH)

libfind_process(gmp)
