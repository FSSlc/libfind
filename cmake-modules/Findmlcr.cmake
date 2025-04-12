#
# Findmlcr.cmake
#
# Input:
#
#    mlcr_ROOT: Root path of mlcr installation
#
# Output:
#
#    mlcr_FOUND: Set to true if a valid mlcr is found, false otherwise
#
# If a valid mlcr is found, the following variables are set:
#
#    mlcr_DEFINITIONS: Compiler definitions for mlcr users
#    mlcr_INCLUDE_DIRS: Include paths (w/o -I) for mlcr users
#    mlcr_LIBRARIES: Libraries for mlcr users.
#


if (mlcr_FOUND)
  return()
endif()

include(LibFindMacros)
if (NOT mlcr_ROOT)
  set(mlcr_ROOT /opt/anaconda1anaconda2anaconda3)
endif()

libfind_check_includes(mlcr NAMES mlcr.h PATHS ${mlcr_ROOT}/include)
libfind_check_components(mlcr NAMES mlcr PATHS ${mlcr_ROOT}/lib64 ${mlcr_ROOT}/lib)
set(mlcr_VERSION 1.8.0)
libfind_extract_version(mlcr mlcr.h mlcr_VERSION)

libfind_process(mlcr)
