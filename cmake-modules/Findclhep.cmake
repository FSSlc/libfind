# 输入变量:
# 输入clhep_ROOT, THIRDLIB_PATH,
# 依据这两个输入路径搜索需要的头文件和库文件,
#
# 输出变量:
# 输出clhep_FOUND, clhep_INCLUDE_DIRS, clhep_LIBRARIES,

if (clhep_FOUND)
  return()
endif()

include(LibFindMacros)
if (NOT clhep_ROOT)
  set(clhep_ROOT  /opt/anaconda1anaconda2anaconda3)
endif ()

libfind_check_dependencies(clhep NAMES  QUIET)
libfind_check_includes(clhep NAMES CLHEP
  PATHS ${clhep_ROOT}/include NO_DEFAULT_PATH)
libfind_check_components(clhep NAMES CLHEP
  PATHS ${clhep_ROOT}/lib NO_DEFAULT_PATH)

libfind_process(clhep)
