#
# Findscotch.cmake
#
# This module handles standard FindXXX for scotch. It requires users to set
# "scotch_ROOT" so as to locate scotch path. 
#
# Input:
#
#    scotch_ROOT: Root path of scotch installation
#
# Output:
#
#    scotch_FOUND: Set to true if a valid scotch is found, false otherwise
#
#  If a void scotch is found, the following variables are set:
#
#    scotch_DEFINITIONS: Compiler definitions for scotch users
#    scotch_INCLUDE_DIRS: Include paths (w/o -I) for scotch users
#    scotch_LIBRARIES: Libraries for scotch users.
#

if (NOT scotch_ROOT)
  set(scotch_ROOT @INSTALL_PREFIX@)
endif ()

#find depends 
set(scotch_deps_DEFINITIONS "")
set(scotch_deps_INCLUDE_DIRS "")
set(scotch_deps_LIBRARIES "")
if (NOT EXISTS @INSTALL_PREFIX@/share/cmake/cmake-modules)
  message(FATAL_ERROR "Directory '@INSTALL_PREFIX@' does not seem to contain find modules")
endif()
list(APPEND CMAKE_MODULE_PATH "@INSTALL_PREFIX@/share/cmake/cmake-modules")
set (REQUIRED_DEPENDS_PKGS mpi)
foreach (_pkg ${REQUIRED_DEPENDS_PKGS})
  find_package(${_pkg} REQUIRED)
  if (${_pkg}_FOUND)
    if (${_pkg}_DEFINITIONS)
      list(APPEND scotch_deps_DEFINITIONS ${${_pkg}_DEFINITIONS})
    endif()
    if (${_pkg}_FLAGS)
      list(APPEND scotch_deps_DEFINITIONS ${${_pkg}_FLAGS})
    endif()
    list(APPEND scotch_deps_INCLUDE_DIRS ${${_pkg}_INCLUDES})
    list(APPEND scotch_deps_LIBRARIES ${${_pkg}_LIBRARIES})
  else()
    message(FATAL_ERROR "Package required but not found: ${_pkg}")
  endif()
endforeach ()

#find self include file
find_file(scotch_INCLUDE_DIR NAMES include PATHS ${scotch_ROOT} NO_DEFAULT_PATH)
if (scotch_INCLUDE_DIR)
  # do nothing
elseif (scotch_FIND_REQUIRED)
  message(FATAL_ERROR "Not found 'include' directory in ${scotch_ROOT}")
endif ()
set(scotch_DEFINITION "")

#find self libraries
if (NOT scotch_COMPONENTS)
  set(scotch_COMPONENTS scotch)
endif ()
foreach (module ${scotch_COMPONENTS})
  find_library(scotch_COMPONENT_${module} NAMES ${module} PATHS ${scotch_ROOT}
    PATH_SUFFIXES lib NO_DEFAULT_PATH)
  if (scotch_COMPONENT_${module})
    list(APPEND scotch_LIBRARIE ${scotch_COMPONENT_${module}})
  else()
    message(FATAL_ERROR "scotch Component required but not found: ${module}")
  endif()
endforeach ()

#merge depends and self
set(scotch_DEFINITIONS "${scotch_deps_DEFINITIONS};${scotch_DEFINITION}")
set(scotch_INCLUDE_DIRS "${scotch_deps_INCLUDE_DIRS};${scotch_INCLUDE_DIR}")
set(scotch_LIBRARIES "${scotch_deps_LIBRARIES};${scotch_LIBRARIE}")

#output message
if (NOT scotch_FIND_QUIETLY)
  message(STATUS "Found scotch: ${scotch_LIBRARIES} in ${scotch_ROOT}")
endif ()
if (scotch_INCLUDE_DIRS AND scotch_LIBRARIES)
  set(scotch_FOUND TRUE)
else ()
  set(scotch_FOUND FALSE)
endif ()

#compatible old
if (scotch_INCLUDE_DIRS)
  list(APPEND THIRDLIB_INCLUDES ${scotch_INCLUDE_DIRS})
endif ()
if (scotch_LIBRARIES)
  list(APPEND THIRDLIB_LIBRARIES ${scotch_LIBRARIES})
endif ()