#
# Findrttr.cmake
#
# Input:
#
#    rttr_ROOT: Root path of metis installation
#
# Output:
#
#    rttr_FOUND: Set to true if a valid metis is found, false otherwise
#
#  If a void metis is found, the following variables are set:
#
#    metis_DEFINITIONS: Compiler definitions for metis users
#    metis_INCLUDE_DIRS: Include paths (w/o -I) for metis users
#    metis_LIBRARIES: Libraries for metis users.
#


if (rttr_FOUND)
    return()
endif()

include(LibFindMacros)
if (NOT rttr_ROOT)
    set(rttr_ROOT /opt/anaconda1anaconda2anaconda3)
endif ()

libfind_check_includes(rttr NAMES variant.h
        PATHS ${rttr_ROOT}/include/rttr NO_DEFAULT_PATH)
libfind_check_components(rttr NAMES rttr_core_d
        PATHS ${rttr_ROOT}/lib64 NO_DEFAULT_PATH)
libfind_process(rttr)
