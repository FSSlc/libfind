#
# Findmumps.cmake
#
# Input:
#
#    mumps_ROOT: Root path of mumps installation
#
# Output:
#
#    mumps_FOUND: Set to true if a valid mumps is found, false otherwise
#
#  If a void mumps is found, the following variables are set:
#
#    mumps_DEFINITIONS: Compiler definitions for mumps users
#    mumps_INCLUDE_DIRS: Include paths (w/o -I) for mumps users
#    mumps_LIBRARIES: Libraries for mumps users.
#


if (mumps_FOUND)
  return()
endif()

include(LibFindMacros)
if (NOT mumps_ROOT)
  set(mumps_ROOT /opt/anaconda1anaconda2anaconda3)
endif ()

libfind_check_dependencies(mumps NAMES mpi metis parmetis scalapack REQUIRED QUIET)
libfind_check_includes(mumps NAMES mumps_c_types.h dmumps_c.h
  PATHS ${mumps_ROOT}/include NO_DEFAULT_PATH)
if (NOT mumps_FIND_COMPONENTS)
  set(mumps_FIND_COMPONENTS cmumps dmumps smumps zmumps mumps_common pord)
endif()
libfind_check_components(mumps NAMES ${mumps_FIND_COMPONENTS}
  PATHS ${mumps_ROOT}/lib NO_DEFAULT_PATH)
libfind_extract_version(mumps dmumps_c.h MUMPS_VERSION)

libfind_process(mumps)
