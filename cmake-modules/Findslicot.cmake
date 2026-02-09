#
# Findslicot.cmake
#
# Input:
#
#    slicot_ROOT: Root path of slicot installation
#
# Output:
#
#    slicot_FOUND: Set to true if a valid slicot is found, false otherwise
#
#  If a void slicot is found, the following variables are set:
#
#    slicot_LIBRARIES: Libraries for slicot users.
#


if (slicot_FOUND)
  return()
endif()

include(LibFindMacros)
if (NOT slicot_ROOT)
  set(slicot_ROOT /opt/anaconda1anaconda2anaconda3)
endif ()


libfind_check_dependencies(slicot NAMES fortran REQUIRED QUIET)
libfind_check_components(slicot NAMES slicot lpkaux
  PATHS ${slicot_ROOT}/lib64 ${slicot_ROOT}/lib NO_DEFAULT_PATH)

libfind_process(slicot)
