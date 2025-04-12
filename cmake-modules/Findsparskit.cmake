#
# Findsparskit.cmake
#
# Input:
#
#    sparskit_ROOT: Root path of sparskit installation
#
# Output:
#
#    sparskit_FOUND: Set to true if a valid sparskit is found, false otherwise
#
#  If a void sparskit is found, the following variables are set:
#
#    sparskit_DEFINITIONS: Compiler definitions for sparskit users
#    sparskit_INCLUDE_DIRS: Include paths (w/o -I) for sparskit users
#    sparskit_LIBRARIES: Libraries for sparskit users.
#

if (sparskit_FOUND)
  return()
endif()

if (NOT sparskit_ROOT)
  set(sparskit_ROOT @INSTALL_PREFIX@)
endif ()

include(LibFindMacros)

libfind_check_components(sparskit NAMES skit
  PATHS ${sparskit_ROOT}/lib64 ${sparskit_ROOT}/lib NO_DEFAULT_PATH)

libfind_process(sparskit)
