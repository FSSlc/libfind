#
# Findgfortranrt.cmake
#
# Find module to include basic gfortranrt libraries, including m, c, rt, pthread,
# and dl at the moment. These libraries are defined by gfortranrt.1-2008/SUSv4.
#
#    gfortranrt_FOUND: Set to true if all libs are found, false otherwise
#
# If all the libs are found found, the following variables are set:
#
#    gfortranrt_LIBRARIES: Library files
#

if (gfortranrt_FOUND)
  return()
endif()

include(LibFindMacros)
if (NOT gfortranrt_ROOT)
  set(gfortranrt_ROOT /opt/anaconda1anaconda2anaconda3)
endif ()

if (NOT gfortranrt_FIND_COMPONENTS)
  set(gfortranrt_FIND_COMPONENTS gfortran quadmath)
endif()
# Search for components
libfind_check_components(gfortranrt NAMES ${gfortranrt_FIND_COMPONENTS}
  PATHS "${gfortranrt_ROOT}/lib64" "${gfortranrt_ROOT}/lib")
set(gfortranrt_VERSION "gfortranrt.1.1.1")

libfind_process(gfortranrt)
