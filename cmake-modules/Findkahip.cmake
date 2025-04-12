#
# Findkahip.cmake
#
# This module handles standard FindXXX for kahip. It requires users to set
# "kahip_ROOT" so as to locate kahip path. 
#
# Input:
#
#    kahip_ROOT: Root path of kahip installation
#
# Output:
#
#    kahip_FOUND: Set to true if a valid kahip is found, false otherwise
#
#  If a void kahip is found, the following variables are set:
#
#    kahip_DEFINITIONS: Compiler definitions for kahip users
#    kahip_INCLUDE_DIRS: Include paths (w/o -I) for kahip users
#    kahip_LIBRARIES: Libraries for kahip users.
#

if (kahip_FOUND)
  return()
endif()

include(LibFindMacros)
if (NOT kahip_ROOT)
  set(kahip_ROOT /opt/anaconda1anaconda2anaconda3)
endif ()

libfind_check_dependencies(kahip NAMES mpi REQUIRED QUIET)

libfind_check_includes(kahip NAMES kaHIP_interface.h parhip_interface.h
  PATHS ${kahip_ROOT}/include NO_DEFAULT_PATH)

if (EXISTS ${kahip_ROOT}/include/kaHIP_version.h) 

  # extract version
  file(READ "${kahip_ROOT}/include/kaHIP_version.h" _TMP)
  string(REGEX REPLACE ".*const std\:\:string KAHIPVERSION = \"v([0-9]+)\.([0-9]+)\";.*" "\\1\.\\2" kahip_VERSION "${_TMP}")
  unset(_TMP)

  libfind_check_components(kahip NAMES kahip parhip_interface
    PATHS ${kahip_ROOT}/lib NO_DEFAULT_PATH)
else() # In order to be compatible with old version before(include) kahip-3.10

  libfind_check_components(kahip NAMES parhip_interface interface
    PATHS ${kahip_ROOT}/lib NO_DEFAULT_PATH)
endif()

libfind_process(kahip)
