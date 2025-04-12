cmake_minimum_required(VERSION 3.3)
include(CMakePrintHelpers)
include(CMakeParseArguments)

#
# pkgutils::package is a tool to assist build a package of objects. The source
# files can scatter among arbitrarily nested directory hiererchies. Each file
# can have file-specific properties such as COMPILE_OPTIONS, COMPILE_DEFINITIONS
# and INCLUDE_DIRECTORIES. The package itself can produce multiple library
# targets, each have their own properties.
#
# A typical usage of this tool is as follows:
#
# 1. In the upper-most directory, initialize the package in the CMakeLists.txt:
#     pkgutils_package_init(MyPackage)
# 2. In source directories, add files to the package:
#     pkgutils_package_add_files(MyPackage FILES foo.cpp bar.cpp foo.h PROPERTIES
#       COMPILE_DEFINITIONS NDIM=2 INCLUDE_DIRECTORIES ${a_INCLUDE_DIRS})
#     pkgutils_package_link_files(MyPackage FILES foo.cpp bar.cpp foo.h
#       DESTINATION ${PROJECT_BINARY_DIR}/include)
# 3. In the upper-most directory, create library using the added files:
#     pkgutils_package_add_library(MyPackage TARGET mypackage-opt OBJECT)
#     target_compile_options(mypackage-opt "-O2;-g;-DNDEBUG")
#     pkgutils_package_add_library(MyPackage TARGET mypackage-dbg OBJECT)
#     target_compile_options(mypackage-dbg "-O0;-g;-UNDEBUG")
#


#
# _pkgutils_parse_args(<PREFIX> <OPTIONS> <ONE_PARAM_ARGS> <MULTI_PARAM_ARGS>)
#
# A wrapper of cmake_parse_arguments where all one or multi parameter arguments
# shall be supplied.
#
macro (_pkgutils_parse_args PREFIX OPTIONS ONE_PARAM_ARGS MULTI_PARAM_ARGS)
  cmake_parse_arguments("${PREFIX}" "${OPTIONS}" "${ONE_PARAM_ARGS}"
    "${MULTI_PARAM_ARGS}" "${ARGN}")
  foreach (keyword ${ONE_PARAM_ARGS} ${MULTI_PARAM_ARGS})
    if (NOT ${PREFIX}_${keyword})
      message(FATAL_ERROR "${PREFIX}: Keyword ${PREFIX}_${keyword} is required"
      "but not supplied")
    endif()
  endforeach()
endmacro()

#
# pkgutils_package_init(PKG_NAME)
#
# Initialize a package. This will clean internal storage of package source files
#
function (pkgutils_package_init PKG_NAME)
  set(${PKG_NAME}_SOURCE_FILES "" CACHE INTERNAL
    "Source files for package '${PKG_NAME}'" FORCE)
endfunction()

#
# pkgutils_package_add_sources(PKG_NAME FILES <file>...
#                              [PROPERTIES <name> <value>... <name> <value>...])
#
# Add files in FILES to package PKG_NAME's sources, and set specified source
# file properties. Allowed properties at the moment are COMPILE_OPTIONS,
# COMPILE_DEFINITIONS, COMPILE_FLAGS and INCLUDE_DIRECTORIES. The properties
# are restricted by the ability of set_source_files_properties so it is only
# visible to target in the same directory.
#
function (pkgutils_package_add_sources PKG_NAME)
  cmake_parse_arguments(PPAS "" "" "FILES;PROPERTIES" ${ARGN})
  if (NOT PPAS_FILES)
    message(FATAL_ERROR "PPAS: Keyword PPAS_FILES is required but not supplied")
  endif()
  set(files ${${PKG_NAME}_SOURCE_FILES})
  foreach (fn ${PPAS_FILES})
    get_filename_component(abspath "${fn}" ABSOLUTE)
    list(APPEND files "${abspath}")
  endforeach()
  set(${PKG_NAME}_SOURCE_FILES "${files}" CACHE INTERNAL
     "Source files for package '${PKG_NAME}'" FORCE)
  set(allowed_props
    "COMPILE_OPTIONS;COMPILE_DEFINITIONS;COMPILE_FLAGS;INCLUDE_DIRECTORIES")
  if (PPAS_PROPERTIES)
    cmake_parse_arguments(PROP "" "" "${allowed_props}" ${PPAS_PROPERTIES})
    foreach(prop ${allowed_props})
      if (NOT PROP_${prop})
        continue()
      endif()
      set_source_files_properties(${PPAS_FILES}
        PROPERTIES ${prop} ${PROP_${prop}})
    endforeach()
  endif()
endfunction()

#
# pkgutils_package_link_files(PKG_NAME FILES <file>... DESTINATION <dest_dir>)
#
# Create symbolic in dest_dir for all files in FILES. Relative paths are treated
# to be in the current CMakeLists directory.
#
function (pkgutils_package_link_files PKG_NAME)
  _pkgutils_parse_args(PPLF "" "DESTINATION" "FILES" ${ARGN})
  get_filename_component(PPLF_DESTINATION "${PPLF_DESTINATION}" ABSOLUTE)
  if (NOT EXISTS "${PPLF_DESTINATION}")
    file(MAKE_DIRECTORY "${PPLF_DESTINATION}")
  endif()
  foreach (path ${PPLF_FILES})
    get_filename_component(name "${path}" NAME)
    get_filename_component(abspath "${path}" ABSOLUTE)
    execute_process(COMMAND ${CMAKE_COMMAND} -E create_symlink "${abspath}"
      "${PPLF_DESTINATION}/${name}")
  endforeach()
endfunction()

#
# pkgutils_package_add_library(PKG_NAME TARGET <name> [SHARED|STATIC|OBJECT])
#
# Add a library target <name> with current sources of package PKG_NAME. The
# library can be SHARED, STAIC or OBJECT depending on the supplied options. They
# are passed directly to add_library. One can use target_set_properties to
# control the properties and other CMake standard utilities to alter the
# properties.
#
function (pkgutils_package_add_library PKG_NAME)
  cmake_parse_arguments(PPAL "SHARED;STATIC;MODULE;OBJECT" "TARGET" "" ${ARGN})
  if (NOT PPAL_TARGET)
    message("PPAL: Keyword TARGET is required but not supplied")
  endif()
  set(lib_type "")
  foreach (type STATIC SHARED MODULE OBJECT)
    if (PPAL_${type})
      set(lib_type "${type}")
    endif()
  endforeach()
  if (lib_type)
    add_library("${PPAL_TARGET}" "${lib_type}" ${${PKG_NAME}_SOURCE_FILES})
  else()
    add_library("${PPAL_TARGET}" ${${PKG_NAME}_SOURCE_FILES})
  endif()
endfunction()

