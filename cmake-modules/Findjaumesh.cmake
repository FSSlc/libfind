#
# Findjaumesh.cmake
#
# Input:
#
#    jaumesh_ROOT: Root path of jaumesh installation
#
# Output:
#
#    jaumesh_FOUND: Set to true if a valid jaumesh is found, false otherwise
#
#  If a void jaumesh is found, the following variables are set:
#
#    jaumesh_DEFINITIONS: Compiler definitions for jaumesh users
#    jaumesh_INCLUDE_DIRS: Include paths (w/o -I) for jaumesh users
#    jaumesh_LIBRARIES: Libraries for jaumesh users.
#

if (jaumesh_FOUND)
  return()
endif()

if (NOT jaumesh_ROOT)
  set(jaumesh_ROOT @INSTALL_PREFIX@)
endif ()

include(LibFindMacros)

libfind_check_dependencies(jaumesh NAMES metis zoltan mpi REQUIRED QUIET)
libfind_check_includes(jaumesh NAMES Mesher.h Mesh.h
  PATHS ${jaumesh_ROOT}/include NO_DEFAULT_PATH)
if (NOT jaumesh_FIND_COMPONENTS)
  set(jaumesh_FIND_COMPONENTS jaumesh supmesh meshcore)
  set(jaumesh_FIND_OPTIONAL_COMPONENTS SpaACIS devtools)
endif()
libfind_check_components(jaumesh NAMES ${jaumesh_FIND_COMPONENTS}
  PATHS ${jaumesh_ROOT}/lib NO_DEFAULT_PATH)
libfind_check_components(jaumesh NAMES ${jaumesh_FIND_OPTIONAL_COMPONENTS}
  PATHS ${jaumesh_ROOT}/lib NO_DEFAULT_PATH OPTIONAL)

#libfind_extract_version(jaumesh jad_define.h JAD_RELEASE_STR)

libfind_process(jaumesh)
