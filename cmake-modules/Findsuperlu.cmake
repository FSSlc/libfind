#
# Findsuperlu.cmake
#
# This module handles standard FindXXX for superlu. It requires users to set
# "superlu_ROOT" so as to locate superlu path. 
#
# Input:
#
#    superlu_ROOT: Root path of superlu installation
#
# Output:
#
#    superlu_FOUND: Set to true if a valid superlu is found, false otherwise
#
#  If a void superlu is found, the following variables are set:
#
#    superlu_DEFINITIONS: Compiler definitions for superlu users
#    superlu_INCLUDE_DIRS: Include paths (w/o -I) for superlu users
#    superlu_LIBRARIES: Libraries for superlu users.
#

include(LibFindMacros)
if (NOT superlu_ROOT)
  set(superlu_ROOT /opt/anaconda1anaconda2anaconda3)
endif ()

#find depends 
set(superlu_deps_DEFINITIONS "")
set(superlu_deps_INCLUDE_DIRS "")
set(superlu_deps_LIBRARIES "")
if (NOT EXISTS /opt/anaconda1anaconda2anaconda3/share/cmake/cmake-modules)
  message(FATAL_ERROR "Directory '/opt/anaconda1anaconda2anaconda3' does not seem to contain find modules")
endif()
list(APPEND CMAKE_MODULE_PATH "/opt/anaconda1anaconda2anaconda3/share/cmake/cmake-modules")
set (REQUIRED_DEPENDS_PKGS openblas)
foreach (_pkg ${REQUIRED_DEPENDS_PKGS})
  find_package(${_pkg} REQUIRED)
  if (${_pkg}_FOUND)
    if (${_pkg}_DEFINITIONS)
      list(APPEND superlu_deps_DEFINITIONS ${${_pkg}_DEFINITIONS})
    endif()
    if (${_pkg}_FLAGS)
      list(APPEND superlu_deps_DEFINITIONS ${${_pkg}_FLAGS})
    endif()
    list(APPEND superlu_deps_INCLUDE_DIRS ${${_pkg}_INCLUDES})
    list(APPEND superlu_deps_LIBRARIES ${${_pkg}_LIBRARIES})
  else()
    message(FATAL_ERROR "Package required but not found: ${_pkg}")
  endif()
endforeach ()

#find self include file
find_file(superlu_INCLUDE_DIR NAMES include PATHS ${superlu_ROOT} NO_DEFAULT_PATH)
if (superlu_INCLUDE_DIR)
  # do nothing
elseif (superlu_FIND_REQUIRED)
  message(FATAL_ERROR "Not found 'include' directory in ${superlu_ROOT}")
endif ()
set(superlu_DEFINITION "")

#find self libraries
if (NOT superlu_COMPONENTS)
  set(superlu_COMPONENTS superlu)
endif ()
foreach (module ${superlu_COMPONENTS})
  find_library(superlu_COMPONENT_${module} NAMES ${module} PATHS ${superlu_ROOT}
    PATH_SUFFIXES lib NO_DEFAULT_PATH)
  if (superlu_COMPONENT_${module})
    list(APPEND superlu_LIBRARIE ${superlu_COMPONENT_${module}})
  else()
    message(FATAL_ERROR "superlu Component required but not found: ${module}")
  endif()
endforeach ()

#merge depends and self
set(superlu_DEFINITIONS "${superlu_deps_DEFINITIONS};${superlu_DEFINITION}")
set(superlu_INCLUDE_DIRS "${superlu_deps_INCLUDE_DIRS};${superlu_INCLUDE_DIR}")
set(superlu_LIBRARIES "${superlu_deps_LIBRARIES};${superlu_LIBRARIE}")

#output message
if (NOT superlu_FIND_QUIETLY)
  message(STATUS "Found superlu: ${superlu_LIBRARIES} in ${superlu_ROOT}")
endif ()
if (superlu_INCLUDE_DIRS AND superlu_LIBRARIES)
  set(superlu_FOUND TRUE)
else ()
  set(superlu_FOUND FALSE)
endif ()

#compatible old
if (superlu_INCLUDE_DIRS)
  list(APPEND THIRDLIB_INCLUDES ${superlu_INCLUDE_DIRS})
endif ()
if (superlu_LIBRARIES)
  list(APPEND THIRDLIB_LIBRARIES ${superlu_LIBRARIES})
endif ()
