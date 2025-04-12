---
title: CMake Find Module Standard
author: Zhang YANG
date: 2017-12-18T00:00:00.000Z
---

# CMake Find Module Standard

This standard is derived from the `CMake Developer -> Find Modules` section of cmake mannual. It tries to be consistant across all libraries used in SCNS.

## Naming and installation

A find module is an `FindXXX.cmake` file used by `find_package` to provide information to use a certain software package. The file shall be provided by the package itself and installed at `<prefix>/share/cmake/cmake-modules-scns` and named `Find<pkg>.cmake`, where the `<pkg>` is the exact name of the package.

## Inputs and outputs

A find module can accept cmake variables and adjust its output w.r.t. these variables. These variables are defined by the module itself and arbitrary variables are allowed. Yet, they shall conform to the following requirements:

1. Every variable shall be of form `<pkg>_VAR`, `<pkg>` is the **exact name** of the package, and `VAR` is the upper case form of a c identifier.
2. Every variable shall be documented in the module header.
3. Every variable shall have a valid default value, so that `find_package` can return valid results at any time.

The following variables are required to be handled:

1. `<pkg>_ROOT`: The base directory of package `<pkg>`
2. `<pkg>_FIND_REQUIRED`: Whether the package is required to be found. This is defined by `find_package`.
3. `<pkg>_FIND_QUIETLY`: Whether to find the package silently. This is defined by `find_package`.
4. (Optional) `<pkg>_FIND_COMPONENTS`: Which components to find. This is defined by `find_package`.

A find module notifies `find_package` about the information it finds through predefined variables. The following variables shall be defined whenever possible:

1. `<pkg>_FOUND`: whether the package is found or not
2. `<pkg>_DEFINITIONS`: compile flags other than include directories to use the package
3. `<pkg>_INCLUDE_DIRS`: include directories (w/o -I) to use the package
4. `<pkg>_LIBRARIES`: library files to use the package
5. `<pkg>_VERSION`: A string denoting the version of the package. Optionally `<pkg>_VERSION_{MAJOR,MINOR,PATCH}` can be set for the corresponding part of the package version string.

Optionally, the find module can define `<pkg>_<lang>_COMPILER` variables if it requires special compilers to use. Here the `<lang>` can be `C`, `C++` and `Fortran`.

The outputed `<pkg>_DEFINITIONS`, `<pkg>_INCLUDE_DIRS`, and `<pkg>_LIBRARIES` shall contain both that for the package itself and its dependencies.

We highly discourage usage of the COMPILER variables in CMakeLists except that the variable is used to generate configure files. Nake compilers with explicit compile and link flags is better for portability. Compiler wrappers such as mpicc often append extra libraries even when compiling shared libraries. This causes a hard binding of the building environment to the resultant library object.

## Behaviors

The developers are free to use any techniques to implement a find module, as long as the following guidelines are met:

1. A find module shall avoid unnecessary repeated check if the module is already detected at the time of calling.
2. A find module shall work even when no input variables are given.
3. A find module shall avoid variable name collisions with other modules. It is recommended to prefix each internal variable with the package name, and clear them after internal usage.
4. A find module shall be as quiet as possible, but it shall notify the users in case of problems, or required.
5. A find module shall check all the package's direct dependencies, and forward the `QUIET` and `REQUIRED` options to the dependencies.

We recommend to use the **LibFindMacros** library from **cmake-modules-scns** to implement a find module.

# Find Module Best Practices

1. Packages without external dependencies:

```cmake
if (${pkg}_FOUND)
  return()
endif()

if (NOT ${pkg}_ROOT)
  set(${${pkg}_ROOT} xxx)
endif()

include(LibFindMacros)
libfind_check_includes(${pkg} NAMES libmesh.h
  PATHS ${${pkg}_ROOT}/include NO_DEFAULT_PATH)
libfind_check_components(${pkg} NAMES ${components}
  PATHS ${${pkg}_ROOT}/lib NO_DEFAULT_PATH)

include(${pkg}Version.cmake)
libfind_process(${pkg})
```

2. Packages with external dependencies

```cmake
if (${pkg}_FOUND)
  return()
endif()

if (NOT ${pkg}_ROOT)
  set(${pkg_ROOT} xxx)
endif()

include(LibFindMacros)

set(${pkg}_DEPS @PKG_DEPENDENCIES@)
libfind_check_dependencies(${pkg} NAMES ${${pkg}_DEPS} REQUIRED QUIET)

libfind_check_includes(${pkg} NAMES libmesh.h
  PATHS ${${pkg}_ROOT}/include NO_DEFAULT_PATH)
libfind_check_components(${pkg} NAMES ${components}
  PATHS ${${pkg}_ROOT}/include NO_DEFAULT_PATH)

include(${pkg}Version.cmake) # Or directly set the version.
libfind_process(${pkg})
```

3. Packages with pkg-config config file:

```cmake
if (${pkg}_FOUND)
  return()
endif()

if (NOT ${pkg}_ROOT)
  set(${${pkg}_ROOT} xxx)
endif()

include(LibFindMacros)
set(tmp $ENV{PKG_CONFIG_PATH})
set(ENV{PKG_CONFIG_PATH} ${${pkg}_ROOT}/lib/pkgconfig)
libfind_check_pkgconfig(${pkg} PKGNAME>PKGVER)
set(ENV{PKG_CONFIG_PATH} "${tmp}")

libfind_process(${pkg})
```

4. Find dependencies in CMakeLists.txt

```cmake
include(LibFindMacros)
libfind_check_external_packages(pkg_deps NAMES mpi openmp jasmin4 REQUIRED)
libfind_check_external_packages(pkg_deps_opt NAMES fftw)
# Do what ever you want with the output of the packages, and they are standard.
include_directories(${pkg_deps_INCLUDE_DIRS})
add_definitions(${pkg_deps_DEFINITIONS})
target_link_libraries(pkg ${pkg_deps_LIBRARIES})
```

Please refer to bundled cmake find modules for more examples.
