#
# Findnlopt.cmake
#
# This module handles standard FindXXX for nlopt. It requires users to set
# "nlopt_ROOT" so as to locate nlopt path. 
#
# Input:
#
#    nlopt_ROOT: Root path of nlopt installation
#
# Output:
#
#    nlopt_FOUND: Set to true if a valid nlopt is found, false otherwise
#
#  If a void nlopt is found, the following variables are set:
#
#    nlopt_DEFINITIONS: Compiler definitions for nlopt users
#    nlopt_INCLUDE_DIRS: Include paths (w/o -I) for nlopt users
#    nlopt_LIBRARIES: Libraries for nlopt users.
#

if (nlopt_FOUND)
  return()
endif()

include(LibFindMacros)
if (NOT nlopt_ROOT)
  set(nlopt_ROOT /opt/anaconda1anaconda2anaconda3)
endif ()

libfind_check_dependencies(nlopt NAMES QUIET)
libfind_check_includes(nlopt NAMES nlopt.hpp
  PATHS ${nlopt_ROOT}/include NO_DEFAULT_PATH)
libfind_check_components(nlopt NAMES nlopt
  PATHS ${nlopt_ROOT}/lib NO_DEFAULT_PATH)
libfind_extract_version(nlopt nlopt_config.h MAJOR_VERSION MINOR_VERSION  
	BUGFIX_VERSION AS_INTS)

libfind_process(nlopt)
