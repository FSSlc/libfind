#
# Findlua.cmake
#
# A wrapper for lua DEVELOPMENT package
# Input:
#
#    lua_ROOT: Root path of lua installation
#
# Output:
#
#    lua_FOUND: Set to true if a valid lua is found, false otherwise
#
#  If a lua is found, the following variables are set:
#
#    lua_INCLUDE_DIRS: Include paths (w/o -I) for lua users
#    lua_LIBRARIES: Libraries for lua users.
#

if ($<UPPER_CASE:${ENABLE_LUA}> STREQUAL "NO") 
	return()
endif()

if (lua_FOUND)
  return()
endif()

include(LibFindMacros)
if (NOT lua_ROOT)
	set(lua_ROOT "/opt/anaconda1anaconda2anaconda3")
endif ()

libfind_check_includes(lua NAMES lua.h
  PATHS ${lua_ROOT}/include NO_DEFAULT_PATH)
libfind_check_components(lua NAMES lua
  PATHS ${lua_ROOT}/lib64 ${lua_ROOT}/lib NO_DEFAULT_PATH)
libfind_extract_version(lua lua.h LUA_VERSION_MAJOR LUA_VERSION_MINOR LUA_VERSION_RELEASE)

libfind_process(lua)
