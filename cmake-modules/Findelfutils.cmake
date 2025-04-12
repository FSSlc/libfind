#
# Findelfutils.cmake
#
# Input:
#
#    elfutils_ROOT: Root path of elfutils installation
#
# Output:
#
#    elfutils_FOUND: Set to true if a valid elfutils is found, false otherwise
#
# If a valid elfutils is found, the following variables are set:
#
#    elfutils_DEFINITIONS: Compiler definitions for elfutils users
#    elfutils_INCLUDE_DIRS: Include paths (w/o -I) for elfutils users
#    elfutils_LIBRARIES: Libraries for elfutils users.
#


if (elfutils_FOUND)
  return()
endif()

include(LibFindMacros)
if (NOT elfutils_ROOT)
  set(elfutils_ROOT /opt/anaconda1anaconda2anaconda3)
endif()

# we have no dependent packages
libfind_check_includes(elfutils NAMES elfutils/libdw.h elfutils/version.h
  PATHS ${elfutils_ROOT}/include NO_DEFAULT_PATH)
if (NOT elfutils_FIND_COMPONENTS)
  set(elfutils_FIND_COMPONENTS dw)
endif()
libfind_check_components(elfutils NAMES ${elfutils_FIND_COMPONENTS}
  PATHS ${elfutils_ROOT}/lib NO_DEFAULT_PATH)
libfind_extract_version(elfutils elfutils/version.h _ELFUTILS_VERSION AS_INTS)

libfind_process(elfutils)
