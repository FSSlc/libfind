#
# Findjasmesh.cmake
#
# This module handles standard FindXXX for jasmesh. It requires users to set
# "jasmesh_ROOT" so as to locate jasmesh path. 
#
# Input:
#
#    jasmesh_ROOT: Root path of jasmesh installation
#
# Output:
#
#    jasmesh_FOUND: Set to true if a valid jasmesh is found, false otherwise
#
#  If a void jasmesh is found, the following variables are set:
#
#    jasmesh_DEFINITIONS: Compiler definitions for jasmesh users
#    jasmesh_INCLUDE_DIRS: Include paths (w/o -I) for jasmesh users
#    jasmesh_LIBRARIES: Libraries for jasmesh users.
#

if (NOT jasmesh_ROOT)
  set(jasmesh_ROOT @INSTALL_PREFIX@)
endif ()

#find depends 
set(jasmesh_deps_DEFINITIONS "")
set(jasmesh_deps_INCLUDE_DIRS "")
set(jasmesh_deps_LIBRARIES "")
if (NOT EXISTS @INSTALL_PREFIX@/share/cmake/cmake-modules)
  message(FATAL_ERROR "Directory '@INSTALL_PREFIX@' does not seem to contain find modules")
endif()
list(APPEND CMAKE_MODULE_PATH "@INSTALL_PREFIX@/share/cmake/cmake-modules")
set (REQUIRED_DEPENDS_PKGS mpi)
foreach (_pkg ${REQUIRED_DEPENDS_PKGS})
  find_package(${_pkg} REQUIRED)
  if (${_pkg}_FOUND)
    if (${_pkg}_DEFINITIONS)
      list(APPEND jasmesh_deps_DEFINITIONS ${${_pkg}_DEFINITIONS})
    endif()
    if (${_pkg}_FLAGS)
      list(APPEND jasmesh_deps_DEFINITIONS ${${_pkg}_FLAGS})
    endif()
    list(APPEND jasmesh_deps_INCLUDE_DIRS ${${_pkg}_INCLUDES})
    list(APPEND jasmesh_deps_LIBRARIES ${${_pkg}_LIBRARIES})
  else()
    message(FATAL_ERROR "Package required but not found: ${_pkg}")
  endif()
endforeach ()

#find self include file
find_file(jasmesh_INCLUDE_DIR NAMES include PATHS ${jasmesh_ROOT} NO_DEFAULT_PATH)
if (jasmesh_INCLUDE_DIR)
  # do nothing
elseif (jasmesh_FIND_REQUIRED)
  message(FATAL_ERROR "Not found 'include' directory in ${jasmesh_ROOT}")
endif ()
set(jasmesh_DEFINITION "")

#find self libraries
if (NOT jasmesh_COMPONENTS)
  set(jasmesh_COMPONENTS jasmesh)
endif ()
foreach (module ${jasmesh_COMPONENTS})
  find_library(jasmesh_COMPONENT_${module} NAMES ${module} PATHS ${jasmesh_ROOT}
    PATH_SUFFIXES lib NO_DEFAULT_PATH)
  if (jasmesh_COMPONENT_${module})
    list(APPEND jasmesh_LIBRARIE ${jasmesh_COMPONENT_${module}})
  else()
    message(FATAL_ERROR "jasmesh Component required but not found: ${module}")
  endif()
endforeach ()

#merge depends and self
set(jasmesh_DEFINITIONS "${jasmesh_deps_DEFINITIONS};${jasmesh_DEFINITION}")
set(jasmesh_INCLUDE_DIRS "${jasmesh_deps_INCLUDE_DIRS};${jasmesh_INCLUDE_DIR}")
set(jasmesh_LIBRARIES "${jasmesh_deps_LIBRARIES};${jasmesh_LIBRARIE}")

#output message
if (NOT jasmesh_FIND_QUIETLY)
  message(STATUS "Found jasmesh: ${jasmesh_LIBRARIES} in ${jasmesh_ROOT}")
endif ()
if (jasmesh_INCLUDE_DIRS AND jasmesh_LIBRARIES)
  set(jasmesh_FOUND TRUE)
else ()
  set(jasmesh_FOUND FALSE)
endif ()

#compatible old
if (jasmesh_INCLUDE_DIRS)
  list(APPEND THIRDLIB_INCLUDES ${jasmesh_INCLUDE_DIRS})
endif ()
if (jasmesh_LIBRARIES)
  list(APPEND THIRDLIB_LIBRARIES ${jasmesh_LIBRARIES})
endif ()