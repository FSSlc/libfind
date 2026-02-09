#
# Findgsl.cmake
#
# Input:
#
#    gsl_ROOT: Root path of gsl installation
#
# Output:
#
#    gsl_FOUND: Set to true if a valid gsl is found, false otherwise
#
#  If a void gsl is found, the following variables are set:
#
#    gsl_DEFINITIONS: Compiler definitions for gsl users
#    gsl_INCLUDE_DIRS: Include paths (w/o -I) for gsl users
#    gsl_LIBRARIES: Libraries for gsl users.
#

if (gsl_FOUND)
  return()
endif()

include(LibFindMacros)
if (NOT gsl_ROOT)
  set(gsl_ROOT /opt/anaconda1anaconda2anaconda3)
endif ()

libfind_check_includes(gsl NAMES gsl/gsl_version.h
  PATHS ${gsl_ROOT}/include NO_DEFAULT_PATH)
libfind_check_components(gsl NAMES gsl
  PATHS ${gsl_ROOT}/lib64 ${gsl_ROOT}/lib NO_DEFAULT_PATH)
libfind_extract_version(gsl gsl/gsl_version.h GSL_VERSION)

libfind_process(gsl)
