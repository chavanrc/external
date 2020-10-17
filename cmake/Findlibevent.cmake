find_path(libevent_INCLUDE_DIR
        NAMES evdns.h event.h
        PATHS ${LIBEVENT_INCLUDE_DIR}
        NO_CMAKE_SYSTEM_PATH
        NO_SYSTEM_ENVIRONMENT_PATH
        DOC "The directory where libevent includes reside")

set(LIBEVENT_LIBRARIES event)

find_library(libevent_LIBRARY
        NAMES ${LIBEVENT_LIBRARIES}
        PATHS ${LIBEVENT_LIB_PATH}
        NO_CMAKE_SYSTEM_PATH
        NO_SYSTEM_ENVIRONMENT_PATH
        DOC "The libevent library")

if (libevent_INCLUDE_DIR AND libevent_LIBRARY)
    include(FindPackageHandleStandardArgs)
    find_package_handle_standard_args(libevent DEFAULT_MSG
            libevent_INCLUDE_DIR libevent_LIBRARY)
    if (libevent_FOUND)
        add_library(libevent::libevent STATIC IMPORTED)
        set_target_properties(libevent::libevent PROPERTIES
                INTERFACE_INCLUDE_DIRECTORIES "${libevent_INCLUDE_DIR}"
                IMPORTED_LINK_INTERFACE_LANGUAGES "CXX"
                IMPORTED_LOCATION "${libevent_LIBRARY}")
    endif ()
endif ()