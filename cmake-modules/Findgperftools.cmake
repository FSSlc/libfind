#
# Findgperftools.cmake
#
# This module handles standard FindXXX for gperftools. It requires users to set
# "gperftools_ROOT" so as to locate gperftools path. 
#
# Input:
#
#    gperftools_ROOT: Root path of gperftools installation
#
# Output:
#
#    gperftools_FOUND: Set to true if a valid gperftools is found, false otherwise
#
#  If a void gperftools is found, the following variables are set:
#
#    gperftools_DEFINITIONS: Compiler definitions for gperftools users
#    gperftools_INCLUDE_DIRS: Include paths (w/o -I) for gperftools users
#    gperftools_LIBRARIES: Libraries for gperftools users.
#

if (gperftools_FOUND)
  return()
endif()

include(LibFindMacros)
if (NOT gperftools_ROOT)
  set(gperftools_ROOT /opt/anaconda1anaconda2anaconda3)
endif ()

libfind_check_dependencies(gperftools NAMES QUIET)
libfind_check_includes(gperftools NAMES heap-profiler.h heap-checker.h profiler.h tcmalloc.h
  PATHS ${gperftools_ROOT}/include/gperftools NO_DEFAULT_PATH)
libfind_check_components(gperftools NAMES tcmalloc
  PATHS ${gperftools_ROOT}/lib NO_DEFAULT_PATH)
libfind_extract_version(gperftools tcmalloc.h TC_VERSION_MAJOR TC_VERSION_MINOR TC_VERSION_PATCH
	AS_INTS)

libfind_process(gperftools)
