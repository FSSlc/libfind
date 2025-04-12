#
# Findsundials.cmake
#
# Input:
#
#    sundials_ROOT: Root path of sundials installation
#
# Output:
#
#    sundials_FOUND: Set to true if a valid sundials is found, false otherwise
#
#  If a void sundials is found, the following variables are set:
#
#    sundials_DEFINITIONS: Compiler definitions for sundials users
#    sundials_INCLUDE_DIRS: Include paths (w/o -I) for sundials users
#    sundials_LIBRARIES: Libraries for sundials users.
#

if (sundials_FOUND)
  return()
endif()

if (NOT sundials_ROOT)
  set(sundials_ROOT @INSTALL_PREFIX@)
endif ()

include(LibFindMacros)

libfind_check_dependencies(sundials NAMES mpi REQUIRED QUIET)
libfind_check_includes(sundials NAMES sundials/sundials_config.h
  PATHS ${sundials_ROOT}/include NO_DEFAULT_PATH)

if (NOT sundials_FIND_COMPONENTS)
  set(sundials_FIND_COMPONENTS      
     sundials_arkode 
     sundials_cvode
     sundials_cvodes
     sundials_ida
     sundials_idas
     sundials_kinsol
     sundials_nvecserial
     sundials_farkode 
     sundials_fcvode
     sundials_fida
     sundials_fkinsol
     sundials_fnvecserial)
endif()
libfind_check_components(sundials NAMES ${sundials_FIND_COMPONENTS}
  PATHS ${sundials_ROOT}/lib NO_DEFAULT_PATH)
libfind_extract_version(sundials sundials/sundials_config.h
  SUNDIALS_PACKAGE_VERSION)

libfind_process(sundials)
