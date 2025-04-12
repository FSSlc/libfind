#
# Findxerces-c.cmake
#
# Input:
#
#    xerces-c_ROOT: Root path of xerces-c installation
#
# Output:
#
#    xerces-c_FOUND: Set to true if a valid xerces-c is found, false otherwise
#
#  If a void xerces-c is found, the following variables are set:
#
#    xerces-c_DEFINITIONS: Compiler definitions for xerces-c users
#    xerces-c_INCLUDE_DIRS: Include paths (w/o -I) for xerces-c users
#    xerces-c_LIBRARIES: Libraries for xerces-c users.
#

if (xerces-c_FOUND)
  return()
endif()

if (NOT xerces-c_ROOT)
  set(xerces-c_ROOT @INSTALL_PREFIX@)
endif ()

include(LibFindMacros)

libfind_check_dependencies(xerces-c NAMES zlib REQUIRED QUIET)
libfind_check_includes(xerces-c NAMES xercesc/util/XercesDefs.hpp
  PATHS ${xerces-c_ROOT}/include NO_DEFAULT_PATH)
libfind_check_components(xerces-c NAMES xerces-c
  PATHS ${xerces-c_ROOT}/lib64 ${xerces-c_ROOT}/lib NO_DEFAULT_PATH)
libfind_extract_version(xerces-c xercesc/util/XercesVersion.hpp
  XERCES_VERSION_MAJOR XERCES_VERSION_MINOR XERCES_VERSION_REVISION AS_INTS)

libfind_process(xerces-c)
