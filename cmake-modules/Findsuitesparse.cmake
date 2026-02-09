#
# Findsuitesparse.cmake
#
# Input:
#
#    suitesparse_ROOT: Root path of suitesparse installation
#
# Output:
#
#    suitesparse_FOUND: Set to true if a valid suitesparse is found, false otherwise
#
#  If a void suitesparse is found, the following variables are set:
#
#    suitesparse_DEFINITIONS: Compiler definitions for suitesparse users
#    suitesparse_INCLUDE_DIRS: Include paths (w/o -I) for suitesparse users
#    suitesparse_LIBRARIES: Libraries for suitesparse users.
#


if (suitesparse_FOUND)
  return()
endif()

include(LibFindMacros)
if (NOT suitesparse_ROOT)
  set(suitesparse_ROOT /opt/anaconda1anaconda2anaconda3)
endif ()

if (NOT EXISTS ${suitesparse_ROOT}/lib OR NOT EXISTS ${suitesparse_ROOT}/include)
  message(AUTHOR_WARNING "suitesparse at '${suitesparse_ROOT}' is not a regular suitesparse "
    "installation. Only the headers are searched and only the header-only "
    "part would work.")
  libfind_check_includes(suitesparse NAMES SuiteSparse_config.h
    PATHS ${suitesparse_ROOT} NO_DEFAULT_PATH)
else()
  libfind_check_includes(suitesparse NAMES SuiteSparse_config.h
    PATHS ${suitesparse_ROOT}/include NO_DEFAULT_PATH)
  if (NOT suitesparse_FIND_COMPONENTS)
    set(suitesparse_FIND_COMPONENTS suitesparseconfig amd colamd umfpack)
  endif()
  libfind_check_components(suitesparse NAMES ${suitesparse_FIND_COMPONENTS}
    PATHS ${suitesparse_ROOT}/lib NO_DEFAULT_PATH)
endif()

libfind_extract_version(suitesparse SuiteSparse_config.h SUITESPARSE_MAIN_VERSION
                                                        SUITESPARSE_SUB_VERSION
                                                        SUITESPARSE_SUBSUB_VERSION AS_INTS)

libfind_process(suitesparse)