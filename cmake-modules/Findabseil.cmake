#
# Findabseil.cmake
#
# Input:
#
#    abseil_ROOT: Root path of abseil installation
#
# Output:
#
#    abseil_FOUND: Set to true if a valid abseil is found, false otherwise
#
#  If a void abseil is found, the following variables are set:
#
#    abseil_DEFINITIONS: Compiler definitions for abseil users
#    abseil_INCLUDE_DIRS: Include paths (w/o -I) for abseil users
#    abseil_LIBRARIES: Libraries for abseil users.
#
if (abseil_FOUND)
  return()
endif()

include(LibFindMacros)
if (NOT abseil_ROOT)
  set(abseil_ROOT /opt/anaconda1anaconda2anaconda3))
endif ()
set(CMAKE_CXX_STANDARD 11)

libfind_check_includes(abseil NAMES absl/base/config.h
  PATHS ${abseil_ROOT}/include NO_DEFAULT_PATH)
if (NOT abseil_FIND_COMPONENTS)
  # We add all libraries at the moment for easy of usage.
  set(abseil_FIND_COMPONENTS
      absl_bad_any_cast_impl
      absl_bad_optional_access
      absl_bad_variant_access
      absl_base
      absl_city
      absl_civil_time
      absl_cord_internal
      absl_cord
      absl_cordz_functions
      absl_cordz_handle
      absl_cordz_info
      absl_cordz_sample_token
      absl_debugging_internal
      absl_demangle_internal
      absl_examine_stack
      absl_exponential_biased
      absl_failure_signal_handler
      absl_flags_commandlineflag_internal
      absl_flags_commandlineflag
      absl_flags_config
      absl_flags_internal
      absl_flags_marshalling
      absl_flags_parse
      absl_flags_private_handle_accessor
      absl_flags_program_name
      absl_flags_reflection
      absl_flags
      absl_flags_usage_internal
      absl_flags_usage
      absl_graphcycles_internal
      absl_hash
      absl_hashtablez_sampler
      absl_int128
      absl_leak_check
      absl_log_severity
      absl_low_level_hash
      absl_malloc_internal
      absl_periodic_sampler
      absl_random_distributions
      absl_random_internal_distribution_test_util
      absl_random_internal_platform
      absl_random_internal_pool_urbg
      absl_random_internal_randen_hwaes_impl
      absl_random_internal_randen_hwaes
      absl_random_internal_randen_slow
      absl_random_internal_randen
      absl_random_internal_seed_material
      absl_random_seed_gen_exception
      absl_random_seed_sequences
      absl_raw_hash_set
      absl_raw_logging_internal
      absl_scoped_set_env
      absl_spinlock_wait
      absl_stacktrace
      absl_statusor
      absl_status
      absl_strerror
      absl_str_format_internal
      absl_strings_internal
      absl_strings
      absl_symbolize
      absl_synchronization
      absl_throw_delegate
      absl_time
      absl_time_zone)
endif()
libfind_check_components(abseil NAMES ${abseil_FIND_COMPONENTS}
  PATHS ${abseil_ROOT}/lib64 ${abseil_ROOT}/lib NO_DEFAULT_PATH)

file(READ "${abseil_INCLUDE_DIR}/absl/base/config.h" _TMP)
string(REGEX REPLACE ".*#[ \t]*define[ \t]*ABSL_LTS_RELEASE_VERSION[ \t]*([^\n]*).*" "\\1" ABSL_RELEASE_VERSION "${_TMP}")
string(REGEX REPLACE ".*#[ \t]*define[ \t]*ABSL_LTS_RELEASE_PATCH_LEVEL[ \t]*([^\n]*).*" "\\1" ABSL_PATCH_LEVEL "${_TMP}")
set(abseil_VERSION "${ABSL_RELEASE_VERSION}.${ABSL_PATCH_LEVEL}")

libfind_process(abseil GROUP_COMPONENTS)
