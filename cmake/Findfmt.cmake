find_path(fmt_INCLUDE_DIR
        NAMES fmt/core.h
        PATHS ${FMT_INCLUDE_DIR}
        NO_CMAKE_SYSTEM_PATH
        NO_SYSTEM_ENVIRONMENT_PATH)

find_library(fmt_LIB_PATH
        NAMES fmt fmtd
        PATHS ${FMT_LIB_PATH}
        NO_CMAKE_SYSTEM_PATH
        NO_SYSTEM_ENVIRONMENT_PATH)

if (fmt_INCLUDE_DIR AND fmt_LIB_PATH)
    include(FindPackageHandleStandardArgs)
    find_package_handle_standard_args(fmt DEFAULT_MSG
            fmt_LIB_PATH fmt_INCLUDE_DIR)
endif ()
if (fmt_FOUND)
    add_library(fmt::fmt STATIC IMPORTED)
    set_target_properties(fmt::fmt PROPERTIES
            INTERFACE_INCLUDE_DIRECTORIES "${fmt_INCLUDE_DIR}"
            IMPORTED_LINK_INTERFACE_LANGUAGES "CXX"
            IMPORTED_LOCATION "${fmt_LIB_PATH}")
endif ()
