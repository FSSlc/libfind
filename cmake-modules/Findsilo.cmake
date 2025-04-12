# 输入变量:
# 输入silo_ROOT
# 依据这两个输入路径搜索需要的头文件和库文件,
#
# 输出变量:
# 输出silo_FOUND, silo_INCLUDE_DIRS, silo_LIBRARIES,

if (silo_FOUND)
  return()
endif()

include(LibFindMacros)
if (NOT silo_ROOT)
  set(silo_ROOT  "/opt/anaconda1anaconda2anaconda3")
endif ()

libfind_check_dependencies(silo NAMES hdf5 szlib REQUIRED QUIET)
libfind_check_includes(silo NAMES silo.h
  PATHS ${silo_ROOT}/include NO_DEFAULT_PATH)
libfind_check_components(silo NAMES siloh5
  PATHS ${silo_ROOT}/lib NO_DEFAULT_PATH)

libfind_process(silo)
