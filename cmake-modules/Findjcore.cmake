#
# Findjcore.cmake
#
# Input:
#
#    jcore_ROOT: Root path of jcore installation
#
# Output:
#
#    jcore_FOUND: Set to true if a valid jcore is found, false otherwise
#
#  If a void jcore is found, the following variables are set:
#
#    jcore_INCLUDE_DIRS: Include directories for jcore users.
#    jcore_LIBRARIES: Libraries for jcore users.
#

if (jcore_FOUND)
  return()
endif()

if (NOT jcore_ROOT)
  set(jcore_ROOT @INSTALL_PREFIX@)
endif ()

include(LibFindMacros)

libfind_check_includes(jcore NAMES jcore/BasePatch.h
  PATHS ${jcore_ROOT}/include NO_DEFAULT_PATH)
libfind_check_components(jcore NAMES jcore
  PATHS ${jcore_ROOT}/lib NO_DEFAULT_PATH)

libfind_process(jcore)
