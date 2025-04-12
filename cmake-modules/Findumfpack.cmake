#
# Findumfpack.cmake
#
# Input:
#
#    umfpack_ROOT: Root path of umfpack installation
#
# Output:
#
#    umfpack_FOUND: Set to true if a valid umfpack is found, false otherwise
#
#  If a void umfpack is found, the following variables are set:
#
#    umfpack_DEFINITIONS: Compiler definitions for umfpack users
#    umfpack_INCLUDE_DIRS: Include paths (w/o -I) for umfpack users
#    umfpack_LIBRARIES: Libraries for umfpack users.
#


if (umfpack_FOUND)
  return()
endif()

include(LibFindMacros)
if (NOT umfpack_ROOT)
  set(umfpack_ROOT /opt/anaconda1anaconda2anaconda3)
endif ()

libfind_check_includes(umfpack NAMES umfpack.h
  PATHS ${umfpack_ROOT}/include NO_DEFAULT_PATH)
if (NOT umfpack_FIND_COMPONENTS)
  set(umfpack_FIND_COMPONENTS umfpack amd)
endif()
libfind_check_components(umfpack NAMES ${umfpack_FIND_COMPONENTS}
  PATHS ${umfpack_ROOT}/lib NO_DEFAULT_PATH)
libfind_extract_version(umfpack umfpack.h UMFPACK_MAIN_VERSION
  UMFPACK_SUB_VERSION UMFPACK_SUBSUB_VERSION AS_INTS)

libfind_process(umfpack)
