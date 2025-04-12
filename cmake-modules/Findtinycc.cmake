#
# Findtinycc.cmake
#
# This module handles standard FindXXX for tinycc. It requires users to set
# "tinycc_ROOT" so as to locate tinycc path. The standard find_package
# arguments such as "QUIET", "REQUIRED" and "VERSION" is supported.
#
# Input:
#
#    tinycc_ROOT: Root path of tinycc installation, default to install path
#
# Output:
#
#    tinycc_FOUND: Set to true if a valid tinycc is found, false otherwise
#
#  If a valid tinycc is found, the following variables are set:
#
#    tinycc_INCLUDE_DIRS: Include directories for tinycc users.
#    tinycc_LIBRARIES: Libraries for tinycc users.
#

if (tinycc_FOUND)
  return()
endif()

include(LibFindMacros)
if (NOT tinycc_ROOT)
  set(tinycc_ROOT "/opt/anaconda1anaconda2anaconda3")
endif()

libfind_check_includes(tinycc NAMES libtcc.h
  PATHS ${tinycc_ROOT}/include NO_DEFAULT_PATH)
if (NOT TINYCC_FIND_COMPONENTS)
  set(TINYCC_FIND_COMPONENTS tcc)
endif()
libfind_check_components(tinycc NAMES ${TINYCC_FIND_COMPONENTS}
  PATHS ${tinycc_ROOT}/lib NO_DEFAULT_PATH)

#libfind_extract_version(tinycc TINYCC_VERSION)

libfind_process(tinycc)
