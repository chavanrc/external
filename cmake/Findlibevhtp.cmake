find_path(libevhtp_INCLUDE_DIR
        NAMES evhtp.h
        PATHS ${LIBEVHTP_INCLUDE_DIR}
        NO_CMAKE_SYSTEM_PATH
        NO_SYSTEM_ENVIRONMENT_PATH
        DOC "The directory where libevhtp includes reside")

set(LIBEVHTP_LIBRARIES evhtp)

find_library(libevhtp_LIBRARY
        NAMES ${LIBEVHTP_LIBRARIES}
        PATHS ${LIBEVHTP_LIB_PATH}
        NO_CMAKE_SYSTEM_PATH
        NO_SYSTEM_ENVIRONMENT_PATH
        DOC "The libevhtp library")

if (libevhtp_INCLUDE_DIR AND libevhtp_LIBRARY)
    include(FindPackageHandleStandardArgs)
    find_package_handle_standard_args(libevhtp DEFAULT_MSG
            libevhtp_INCLUDE_DIR libevhtp_LIBRARY)
    if (libevhtp_FOUND)
        add_library(libevhtp::libevhtp STATIC IMPORTED)
        set_target_properties(libevhtp::libevhtp PROPERTIES
                INTERFACE_INCLUDE_DIRECTORIES "${libevhtp_INCLUDE_DIR}"
                IMPORTED_LINK_INTERFACE_LANGUAGES "CXX"
                IMPORTED_LOCATION "${libevhtp_LIBRARY}")
    endif ()
endif ()