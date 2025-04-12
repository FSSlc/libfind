#
# Findacis.cmake
#
# This module handles standard FindXXX for acis. It requires users to set
# "acis_ROOT" so as to locate acis path. 
#
# Input:
#
#    acis_ROOT: Root path of acis installation
#
# Output:
#
#    acis_FOUND: Set to true if a valid acis is found, false otherwise
#
#  If a void acis is found, the following variables are set:
#
#    acis_DEFINITIONS: Compiler definitions for acis users
#    acis_INCLUDE_DIRS: Include paths (w/o -I) for acis users
#    acis_LIBRARIES: Libraries for acis users.
#

if (NOT acis_ROOT)
  set(acis_ROOT @INSTALL_PREFIX@)
endif ()

set(acis_DEFINITIONS "")

#find include file
find_file(acis_INCLUDE_DIRS NAMES include PATHS ${acis_ROOT} NO_DEFAULT_PATH)
if (acis_INCLUDE_DIRS)
  # do nothing
elseif (acis_FIND_REQUIRED)
  message(FATAL_ERROR "Not found 'include' directory in ${acis_ROOT}")
endif ()

#find libraries
if (NOT acis_COMPONENTS)
  set(acis_COMPONENTS acis)
endif ()
foreach (module ${acis_COMPONENTS})
  find_library(acis_COMPONENT_${module} NAMES ${module} PATHS ${acis_ROOT}
    PATH_SUFFIXES lib NO_DEFAULT_PATH)
  if (acis_COMPONENT_${module})
    list(APPEND acis_LIBRARIES ${acis_COMPONENT_${module}})
  else()
    message(FATAL_ERROR "acis Component required but not found: ${module}")
  endif()
endforeach ()

#output message
if (NOT acis_FIND_QUIETLY)
  message(STATUS "Found acis: ${acis_LIBRARIES} in ${acis_ROOT}")
endif ()
if (acis_INCLUDE_DIRS AND acis_LIBRARIES)
  set(acis_FOUND TRUE)
else ()
  set(acis_FOUND FALSE)
endif ()

#compatible old
if (acis_INCLUDE_DIRS)
  list(APPEND THIRDLIB_INCLUDES ${acis_INCLUDE_DIRS})
endif ()
if (acis_LIBRARIES)
  list(APPEND THIRDLIB_LIBRARIES ${acis_LIBRARIES})
endif ()