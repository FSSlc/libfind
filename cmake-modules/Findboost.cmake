#
# Findboost.cmake
#
# Input:
#
#    boost_ROOT: Root path of boost installation
#
# Output:
#
#    boost_FOUND: Set to true if a valid boost is found, false otherwise
#
#  If a void boost is found, the following variables are set:
#
#    boost_DEFINITIONS: Compiler definitions for boost users
#    boost_INCLUDE_DIRS: Include paths (w/o -I) for boost users
#    boost_LIBRARIES: Libraries for boost users.
#

if (boost_FOUND)
  return()
endif()

if (NOT boost_ROOT)
  set(boost_ROOT @INSTALL_PREFIX@)
endif ()

include(LibFindMacros)

if (NOT EXISTS ${boost_ROOT}/lib OR NOT EXISTS ${boost_ROOT}/include)
  message(AUTHOR_WARNING "Boost at '${boost_ROOT}' is not a regular boost "
    "installation. Only the headers are searched and only the header-only "
    "part would work.")
  libfind_check_includes(boost NAMES boost/version.hpp
    PATHS ${boost_ROOT} NO_DEFAULT_PATH)
else()
  libfind_check_includes(boost NAMES boost/version.hpp
    PATHS ${boost_ROOT}/include NO_DEFAULT_PATH)
  if (NOT boost_FIND_COMPONENTS)
    set(boost_FIND_COMPONENTS boost_system)
  endif()
  libfind_check_components(boost NAMES ${boost_FIND_COMPONENTS}
    PATHS ${boost_ROOT}/lib64 ${boost_ROOT}/lib NO_DEFAULT_PATH)
endif()
libfind_extract_version(boost boost/version.hpp BOOST_LIB_VERSION)
string(REPLACE "_" "." boost_VERSION ${boost_VERSION})

libfind_process(boost)
