# 输入变量:
# 输入geant4_ROOT, THIRDLIB_PATH,
# 依据这两个输入路径搜索需要的头文件和库文件,
#
# 输出变量:
# 输出geant4_FOUND, geant4_INCLUDE_DIRS, geant4_LIBRARIES,

if (geant4_FOUND)
  return()
endif()

include(LibFindMacros)
if (NOT geant4_ROOT)
  set(geant4_ROOT  /opt/anaconda1anaconda2anaconda3)
endif ()

libfind_check_dependencies(geant4 NAMES  xerces-c clhep QUIET)
libfind_check_includes(geant4 NAMES geant4
  PATHS ${geant4_ROOT}/include/jcogin NO_DEFAULT_PATH)
libfind_check_components(geant4 NAMES GEANT4
  PATHS ${geant4_ROOT}/lib NO_DEFAULT_PATH)

libfind_process(geant4)
