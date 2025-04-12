#
# Findfftw.cmake
#
# Input:
#
#    fftw_ROOT: Root path of fftw installation
#
# Output:
#
#    fftw_FOUND: Set to true if a valid fftw is found, false otherwise
#
#  If a void fftw is found, the following variables are set:
#
#    fftw_DEFINITIONS: Compiler definitions for fftw users
#    fftw_INCLUDE_DIRS: Include paths (w/o -I) for fftw users
#    fftw_LIBRARIES: Libraries for fftw users.
#


if (fftw_FOUND)
  return()
endif()

include(LibFindMacros)
if (NOT fftw_ROOT)
  set(fftw_ROOT /opt/anaconda1anaconda2anaconda3)
endif ()

set(tmp $ENV{PKG_CONFIG_PATH})
set(ENV{PKG_CONFIG_PATH} "${fftw_ROOT}/lib/pkgconfig")
libfind_check_pkgconfig(fftw fftw3)
set(ENV{PKG_CONFIG_PATH} "${tmp}")

libfind_process(fftw)
