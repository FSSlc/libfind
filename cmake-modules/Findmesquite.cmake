#
# Findmesquite.cmake
#
# This module handles standard FindXXX for mesquite. It requires users to set
# "mesquite_ROOT" so as to locate mesquite path. 
#
# Input:
#
#    mesquite_ROOT: Root path of mesquite installation
#
# Output:
#
#    mesquite_FOUND: Set to true if a valid mesquite is found, false otherwise
#
#  If a void mesquite is found, the following variables are set:
#
#    mesquite_DEFINITIONS: Compiler definitions for mesquite users
#    mesquite_INCLUDE_DIRS: Include paths (w/o -I) for mesquite users
#    mesquite_LIBRARIES: Libraries for mesquite users.
#

include(LibFindMacros)
if (NOT mesquite_ROOT)
  set(mesquite_ROOT /opt/anaconda1anaconda2anaconda3)
endif ()

set(mesquite_DEFINITIONS "")

#find include file
find_file(mesquite_INCLUDE_DIRS NAMES include PATHS ${mesquite_ROOT} NO_DEFAULT_PATH)
if (mesquite_INCLUDE_DIRS)
  # do nothing
elseif (mesquite_FIND_REQUIRED)
  message(FATAL_ERROR "Not found 'include' directory in ${mesquite_ROOT}")
endif ()

#find libraries
if (NOT mesquite_COMPONENTS)
  set(mesquite_COMPONENTS mesquite)
endif ()
foreach (module ${mesquite_COMPONENTS})
  find_library(mesquite_COMPONENT_${module} NAMES ${module} PATHS ${mesquite_ROOT}
    PATH_SUFFIXES lib NO_DEFAULT_PATH)
  if (mesquite_COMPONENT_${module})
    list(APPEND mesquite_LIBRARIES ${mesquite_COMPONENT_${module}})
  else()
    message(FATAL_ERROR "mesquite Component required but not found: ${module}")
  endif()
endforeach ()

#output message
if (NOT mesquite_FIND_QUIETLY)
  message(STATUS "Found mesquite: ${mesquite_LIBRARIES} in ${mesquite_ROOT}")
endif ()
if (mesquite_INCLUDE_DIRS AND mesquite_LIBRARIES)
  set(mesquite_FOUND TRUE)
else ()
  set(mesquite_FOUND FALSE)
endif ()

#compatible old
if (mesquite_INCLUDE_DIRS)
  list(APPEND THIRDLIB_INCLUDES ${mesquite_INCLUDE_DIRS})
endif ()
if (mesquite_LIBRARIES)
  list(APPEND THIRDLIB_LIBRARIES ${mesquite_LIBRARIES})
endif ()
