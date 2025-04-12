#
# Findsupermesh.cmake
#
# Input:
#
#    supermesh_ROOT: Root path of supermesh installation
#
# Output:
#
#    supermesh_FOUND: Set to true if a valid supermesh is found, false otherwise
#
#  If a void supermesh is found, the following variables are set:
#
#    supermesh_DEFINITIONS: Compiler definitions for supermesh users
#    supermesh_INCLUDE_DIRS: Include paths (w/o -I) for supermesh users
#    supermesh_LIBRARIES: Libraries for supermesh users.
#

if (supermesh_FOUND)
  return()
endif()

if (NOT supermesh_ROOT)
  set(supermesh_ROOT @INSTALL_PREFIX@)
endif ()

include(LibFindMacros)

libfind_check_dependencies(supermesh NAMES xerces-c mpi REQUIRED QUIET)
libfind_check_includes(supermesh NAMES MeshManager.h supcore.h SupModel.h
  PATHS ${supermesh_ROOT}/include NO_DEFAULT_PATH)
if (NOT supermesh_FIND_COMPONENTS)
  set(supermesh_FIND_COMPONENTS gcad supmodel tet tetgen
      supmesh oce scuuid ocexmll supcore)
  set(supermesh_FIND_OPTIONAL_COMPONENTS SpaACIS devtools)
endif()
libfind_check_components(supermesh NAMES ${supermesh_FIND_COMPONENTS}
  PATHS ${supermesh_ROOT}/lib NO_DEFAULT_PATH)
libfind_check_components(supermesh NAMES ${supermesh_FIND_OPTIONAL_COMPONENTS}
  PATHS ${supermesh_ROOT}/lib NO_DEFAULT_PATH OPTIONAL)

libfind_process(supermesh)
