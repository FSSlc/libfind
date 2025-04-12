# 站点配置

LibFind 提供一套站点配置机制 (Site Config)，允许管理员将 LibFind 中的 Find 模块
的查找路径设置为特定路径，从而实现将特定的库替换为系统上的特定版本。例如，天河 3
号原型系统上提供了深度优化的 FFTW 库，管理员可通过站点配置机制将 fftw_ROOT 设置
为该库的安装路径，所有依赖于 fftw 的库将得到加速。

## 配置接口

管理员在 `<prefix>/share/cmake/Modules/scns` 下创建 `site.cmake` 文件，其内容可
以是任何合法的 CMake 命令。该文件将被 LibFind 读取，其中的 `<pkg>_ROOT` 变量将
被输出。例如：通过如下 `site.cmake` 可将 JASMIN 软件第三方依赖设置到额外路径，
同时确保用户可手动覆盖该设置：

```cmake
set(jasmin_env_pkgs boost fftw hdf5)
foreach (pkg ${jasmin_env_pkgs})
  if (NOT ${pkg}_ROOT)
    set(${pkg}_ROOT /usr/local/tianhe3/software)
  endif()
endforeach()
```

## 对接接口

软件提供给 LibFind 的 Find 模块须实现如下机制，方能对接配置接口支持站点配置：

1. Find 模块内部引用 `LibFindMacros`：

```cmake
if (libfind_ROOT)
  set(libfind_module_path ${libfind_ROOT}/share/cmake/Modules/scns)
  if (NOT libfind_module_path IN_LIST CMAKE_MODULE_PATH)
    list(INSERT CMAKE_MODULE_PATH 0 ${libfind_module_path})
  endif()
  include(LibFindMacros)
else()
  message(FATAL_ERROR "libfind_ROOT is not set")
endif()
```

2. 设置 `<pkg>_ROOT` 变量并以此作为内部唯一的路径指示：

```cmake
if (NOT pkg_ROOT)
   set(pkg_ROOT "@CMAKE_INSTALL_PREFIX@")
endif()
# Any other path is built with ${pkg_ROOT} as the prefix, such as
# `${pkg_ROOT}/include` and `${pkg_ROOT}/lib`
```

LibFind 自带的 Find 模块符合上述规范，可供参考。这些模块位于
`<prefix>/lib/cmake/Modules/scns` 目录下。
