#
# Findhdf5.cmake
#
# Input:
#
#    hdf5_ROOT: Root path of hdf5 installation
#
# Output:
#
#    hdf5_FOUND: Set to true if a valid hdf5 is found, false otherwise
#
#  If a void hdf5 is found, the following variables are set:
#
#    hdf5_DEFINITIONS: Compiler definitions for hdf5 users
#    hdf5_INCLUDE_DIRS: Include paths (w/o -I) for hdf5 users
#    hdf5_LIBRARIES: Libraries for hdf5 users.
#


if (hdf5_FOUND)
  return()
endif()

include(LibFindMacros)
if (NOT hdf5_ROOT)
  set(hdf5_ROOT /opt/anaconda1anaconda2anaconda3)
endif ()

# judge parallel or serial version
# FIXME: when destionation is comment, the result may be wrong
file(READ "${hdf5_ROOT}/include/H5pubconf.h" H5pubconf_header)
set(parallel_define "")
string(REGEX MATCH "#define H5_HAVE_PARALLEL 1" parallel_define "${H5pubconf_header}")
if (${parallel_define})
  libfind_check_dependencies(hdf5 NAMES mpi zlib POSIX szlib REQUIRED QUIET)
else ()
  libfind_check_dependencies(hdf5 NAMES zlib POSIX REQUIRED QUIET)
endif ()

libfind_check_includes(hdf5 NAMES hdf5.h H5pubconf.h
  PATHS ${hdf5_ROOT}/include NO_DEFAULT_PATH)
libfind_check_components(hdf5 NAMES hdf5_hl hdf5
  PATHS ${hdf5_ROOT}/lib NO_DEFAULT_PATH)
libfind_extract_version(hdf5 H5public.h H5_VERS_MAJOR H5_VERS_MINOR
  H5_VERS_RELEASE AS_INTS)

libfind_process(hdf5)
