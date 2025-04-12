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
if ( NOT POSIX_ROOT )
  if (CMAKE_CROSSCOMPILING)
    if(CMAKE_SYSROOT)
      set(POSIX_ROOT "${CMAKE_SYSROOT}")
    else()
      message(FATAL_ERROR "set POSIX_ROOT or CMAKE_SYSROOT! you are in cross compiling mode with no POSIX_ROOT or CMAKE_SYSROOT set")
    endif()
  endif() # end of cross compiling section
  # normal system
  set(POSIX_ROOT "")
endif()

# Search for representive headers of POSIX implementations
libfind_check_includes(POSIX NAMES stdio.h math.h time.h pthread.h dlfcn.h
  PATHS "${POSIX_ROOT}/usr/include")
if (NOT POSIX_FIND_COMPONENTS)
  # All components at the moment: those for the C language, and those for the
  # POSIX standards, includes threads and dlopen.
  set(POSIX_FIND_COMPONENTS m rt pthread dl)
endif()
# Search for components
libfind_check_components(POSIX NAMES ${POSIX_FIND_COMPONENTS}
  PATHS "${POSIX_ROOT}/usr/lib64" "${POSIX_ROOT}/usr/lib")
set(POSIX_VERSION "POSIX.1-2008/SUSv4")

libfind_process(POSIX)
# POSIX shall be provided by the system, so the root dir is not needed
unset(POSIX_ROOT_DIR)
unset(POSIX_ROOT)
