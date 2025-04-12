#
# Findotf2.cmake
#
# This module handles standard FindXXX for otf2. It requires users to set
# "otf2_ROOT" so as to locate otf2 path. The standard find_package
# arguments such as "QUIET", "REQUIRED" and "VERSION" is supported.
#
# Input:
#
#    otf2_ROOT: Root path of otf2 installation, default to install path
#
# Output:
#
#    otf2_FOUND: Set to true if a valid otf2 is found, false otherwise
#
#  If a void otf2 is found, the following variables are set:
#
#    otf2_INCLUDE_DIRS: Include directories for otf2 users.
#    otf2_LIBRARIES: Libraries for otf2 users.
#

if (otf2_FOUND)
  return()
endif()

include(LibFindMacros)
if (NOT otf2_ROOT)
  set(otf2_ROOT "/opt/anaconda1anaconda2anaconda3")
endif()

libfind_check_includes(otf2 NAMES otf2.h
  PATHS ${otf2_ROOT}/include/otf2 NO_DEFAULT_PATH)
if (NOT OTF2_FIND_COMPONENTS)
  set(OTF2_FIND_COMPONENTS otf2)
endif()
libfind_check_components(otf2 NAMES ${OTF2_FIND_COMPONENTS}
  PATHS ${otf2_ROOT}/lib NO_DEFAULT_PATH)

libfind_extract_version(otf2 OTF2_GeneralDefinitions.h OTF2_VERSION)

libfind_process(otf2)
