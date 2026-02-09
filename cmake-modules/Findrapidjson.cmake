#
# Findrapidjson.cmake
#
# Input:
#
#    rapidjson_ROOT: Root path of rapidjson installation
#
# Output:
#
#    rapidjson_FOUND: Set to true if a valid rapidjson is found, false otherwise
#
#  If a void rapidjson is found, the following variables are set:
#
#    rapidjson_LIBRARIES: Libraries for rapidjson users.
#


if (rapidjson_FOUND)
  return()
endif()

include(LibFindMacros)

if (NOT rapidjson_ROOT)
  set(rapidjson_ROOT /opt/anaconda1anaconda2anaconda3)
endif ()

libfind_check_includes(rapidjson NAMES rapidjson/rapidjson.h
  PATHS ${rapidjson_ROOT}/include NO_DEFAULT_PATH)

libfind_process(rapidjson)
