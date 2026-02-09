#
# Findgsl.cmake
#
# Input:
#
#    gsl_ROOT: Root path of readline installation
#
# Output:
#
#    gsl_FOUND: Set to true if a valid readline is found, false otherwise
#
#  If a void readline is found, the following variables are set:
#
#    gsl_DEFINITIONS: Compiler definitions for readline users
#    gsl_INCLUDE_DIRS: Include paths (w/o -I) for readline users
#    gsl_LIBRARIES: Libraries for readline users.
#

if (gsl_FOUND)
  return()
endif()

include(LibFindMacros)
if (NOT gsl_ROOT)
  set(gsl_ROOT /opt/anaconda1anaconda2anaconda3)
endif ()

libfind_check_includes(readline NAMES readline/readline.h
  PATHS ${gsl_ROOT}/include NO_DEFAULT_PATH)
libfind_check_components(readline NAMES readline
  PATHS ${gsl_ROOT}/lib64 ${gsl_ROOT}/lib NO_DEFAULT_PATH)
libfind_extract_version(readline readline/readline.h RL_VERSION_MAJOR RL_VERSION_MINOR AS_INTS)

libfind_process(readline)
