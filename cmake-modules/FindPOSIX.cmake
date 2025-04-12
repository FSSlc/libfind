#
# FindPOSIX.cmake
#
# Find module to include basic posix libraries, including m, c, rt, pthread,
# and dl at the moment. These libraries are defined by POSIX.1-2008/SUSv4.
#
#    POSIX_FOUND: Set to true if all libs are found, false otherwise
#
# If all the libs are found found, the following variables are set:
#
#    POSIX_INCLUDE_DIRS: Include paths (w/o -I) for these libraries
#    POSIX_LIBRARIES: Library files
#

if (POSIX_FOUND)
  return()
endif()

include(LibFindMacros)

# Search for representive headers of POSIX implementations
libfind_check_includes(POSIX NAMES stdio.h math.h time.h pthread.h dlfcn.h
  PATHS /usr/include)
if (NOT POSIX_FIND_COMPONENTS)
  # All components at the moment: those for the C language, and those for the
  # POSIX standards, includes threads and dlopen.
  set(POSIX_FIND_COMPONENTS m rt pthread dl)
endif()
# Search for components
libfind_check_components(POSIX NAMES ${POSIX_FIND_COMPONENTS}
  PATHS /usr/lib64 /usr/lib)
set(POSIX_VERSION "POSIX.1-2008/SUSv4")

libfind_process(POSIX)
# POSIX shall be provided by the system, so the root dir is not needed
unset(POSIX_ROOT_DIR)
unset(POSIX_ROOT)
