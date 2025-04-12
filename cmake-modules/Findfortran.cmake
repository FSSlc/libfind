#
# Findfortran.cmake
#
# This module check fortran compiler and locate the the fortran linking
# libraries so other libraries such as blas can depend on.
#
# Output:
#
#    fortran_FOUND: Set to true if a valid fortran is found, false otherwise
#
#  If a valid fortran is found, the following variables are set:
#
#    fortran_LIBRARIES: Libraries for fortran users.
#

if (fortran_FOUND)
  return()
endif()

if (NOT CMAKE_Fortran_COMPILER STREQUAL "")
  include(LibFindMacros)
  # the fortran library is already detected by the project
  libfind_check_components(fortran NAMES
    ${CMAKE_Fortran_IMPLICIT_LINK_LIBRARIES}
    PATHS ${CMAKE_Fortran_IMPLICIT_LINK_DIRECTORIES})
elseif (fortran_FIND_REQUIRED)
  # required, then there is an error
  message(FATAL_ERROR "Fortran is required but the language is not enabled "
    "for project ${PROJECT_NAME}, use enable_language(Fortran) or add to the "
    "project command")
endif()

libfind_process(fortran)
