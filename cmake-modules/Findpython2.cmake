#
# Findpython2.cmake
#
# A wrapper for python2 DEVELOPMENT package
# Input:
#
#    python2_ROOT: Root path of python2 installation
#
# Output:
#
#    python2_FOUND: Set to true if a valid python2 is found, false otherwise
#
#  If a python2 is found, the following variables are set:
#
#    python2_INCLUDE_DIRS: Include paths (w/o -I) for python2 users
#    python2_LIBRARIES: Libraries for python2 users.
#

if ($<UPPER_CASE:${ENABLE_PYTHON2}> STREQUAL "NO") 
	return()
endif()

if (python2_FOUND)
  return()
endif()

if (NOT python2_ROOT)
	set(python2_ROOT "/opt/anaconda1anaconda2anaconda3")
endif ()
set(Python2_ROOT_DIR ${python2_ROOT})

find_package(Python2 COMPONENTS Development QUIET REQUIRED)

if (NOT Python2_Development_FOUND)
	unset(python2_FOUND) 
	return()
else()
	if (Python2_VERSION_MINOR VERSION_LESS 7)
		message(WARNING "Python2 Development file is found, but version ${Python2_VERSION} (less than 2.7) is not supported")
	unset(python2_FOUND)
	return()
	endif()
endif()
##### Package found: set env
set(python2_FOUND 1)
set(python2_INCLUDE_DIRS "${Python2_INCLUDE_DIRS}")
set(python2_LIBRARIES "${Python2_LIBRARIES}")
#####---------------------------

