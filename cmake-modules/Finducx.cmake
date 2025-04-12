#
# Finducx.cmake
#
# A wrapper for ucx DEVELOPMENT package
# Input:
#
#    ucx_ROOT: Root path of ucx installation
#
# Output:
#
#    ucx_FOUND: Set to true if a valid ucx is found, false otherwise
#
#  If a ucx is found, the following variables are set:
#
#    ucx_INCLUDE_DIRS: Include paths (w/o -I) for ucx users
#    ucx_LIBRARIES: Libraries for ucx users.
#

if ($<UPPER_CASE:${ENABLE_LUA}> STREQUAL "NO") 
	return()
endif()

if (ucx_FOUND)
  return()
endif()

include(LibFindMacros)
if (NOT ucx_ROOT)
	set(ucx_ROOT "/opt/anaconda1anaconda2anaconda3")
endif ()

libfind_check_includes(ucx NAMES ucp.h ucp_version.h
  PATHS ${ucx_ROOT}/include/ucp/api NO_DEFAULT_PATH)
libfind_check_components(ucx NAMES ucp uct ucs ucm
  PATHS ${ucx_ROOT}/lib64 ${ucx_ROOT}/lib NO_DEFAULT_PATH)
libfind_extract_version(ucx ucp_version.h UCP_API_MAJOR UCP_API_MINOR AS_INTS)

libfind_process(ucx)
