#
# Findeigen.cmake
#
# Input:
#
#    eigen_ROOT: Root path of arpack installation
#
# Output:
#
#    eigen_FOUND: Set to true if a valid arpack is found, false otherwise
#
#  If a void arpack is found, the following variables are set:
#
#    eigen_INCLUDE_DIRS: Include paths (w/o -I) for eigen users
#


if (eigen_FOUND)
  return()
endif()

include(LibFindMacros)
if (NOT eigen_ROOT)
  set(eigen_ROOT /opt/anaconda1anaconda2anaconda3)
endif ()

libfind_check_includes(eigen NAMES Eigen PATHS ${eigen_ROOT}/include/eigen3 NO_DEFAULT_PATH)

libfind_process(eigen)
