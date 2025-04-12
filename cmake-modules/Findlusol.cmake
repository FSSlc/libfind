#
# Findlusol.cmake
#
# This module handles standard FindXXX for lusol. It requires users to set
# "lusol_ROOT" so as to locate lusol path. 
#
# Input:
#
#    lusol_ROOT: Root path of lusol installation
#
# Output:
#
#    lusol_FOUND: Set to true if a valid lusol is found, false otherwise
#
#  If a void lusol is found, the following variables are set:
#
#    lusol_DEFINITIONS: Compiler definitions for lusol users
#    lusol_INCLUDE_DIRS: Include paths (w/o -I) for lusol users
#    lusol_LIBRARIES: Libraries for lusol users.
#

if (lusol_FOUND)
  return()
endif()

include(LibFindMacros)
if (NOT lusol_ROOT)
    set(lusol_ROOT "/opt/anaconda1anaconda2anaconda3")
endif ()

libfind_check_dependencies(lusol NAMES QUIET)
libfind_check_includes(lusol NAMES clusol.h
  PATHS ${lusol_ROOT}/include NO_DEFAULT_PATH)
libfind_check_components(lusol NAMES clusol
  PATHS ${lusol_ROOT}/lib NO_DEFAULT_PATH)

libfind_process(lusol)
