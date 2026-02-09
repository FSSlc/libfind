#
# Findadios2.cmake
#
# Input:
#
#    adios2_ROOT: Root path of adios2 installation
#
# Output:
#
#    adios2_FOUND: Set to true if a valid adios2 is found, false otherwise
#
#  If a void adios2 is found, the following variables are set:
#
#    adios2_LIBRARIES: Libraries for adios2 users.
#


if (adios2_FOUND)
  return()
endif()

include(LibFindMacros)
if (NOT adios2_ROOT)
  set(adios2_ROOT /opt/anaconda1anaconda2anaconda3)
endif ()

libfind_check_dependencies(adios2 NAMES mpi gfortranrt BZip2 REQUIRED QUIET)

libfind_check_includes(adios2 NAMES adios2.h
  PATHS ${adios2_ROOT}/include NO_DEFAULT_PATH)

if (NOT adios2_FIND_COMPONENT)
  # We add all libraries at the moment for easy of usage.
  set(adios2_FIND_COMPONENT
    adios2_atl
    adios2_core
    adios2_cxx11
    adios2_evpath
    adios2_c_mpi
    adios2_c
    adios2_dill
    adios2_ffs
    adios2_perfstubs
    adios2_core_mpi
    adios2_cxx11_mpi
    adios2_enet
    adios2_fortran
  )
endif()

libfind_check_components(adios2 NAMES ${adios2_FIND_COMPONENT}
  PATHS ${adios2_ROOT}/lib64 ${adios2_ROOT}/lib NO_DEFAULT_PATH)

libfind_add_definitions(adios2 "-DADIOS2_USE_MPI")

libfind_process(adios2)
