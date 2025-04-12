# 输入变量:
# 输入physics_ROOT, THIRDLIB_PATH,
# 依据这两个输入路径搜索需要的头文件和库文件,
#
# 输出变量:
# 输出physics_FOUND, physics_INCLUDE_DIRS, physics_LIBRARIES,

if (physics_FOUND)
  return()
endif()

include(LibFindMacros)
if (NOT physics_ROOT)
  set(physics_ROOT  /opt/anaconda1anaconda2anaconda3)
endif ()

libfind_check_dependencies(physics NAMES  jcogin QUIET)
libfind_check_includes(physics NAMES physicssimple/GlobalFunction.hh
  PATHS ${physics_ROOT}/include/jcogin NO_DEFAULT_PATH)
libfind_check_components(physics NAMES PhysicsSimple
  PATHS ${physics_ROOT}/lib NO_DEFAULT_PATH)

libfind_process(physics)
