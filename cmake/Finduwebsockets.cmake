find_path(uwebsockets_INCLUDE_DIR
        NAMES uWebSockets/WebSocket.h
        PATHS ${UWEBSOCKETS_INCLUDE_DIR}
        NO_CMAKE_SYSTEM_PATH
        NO_SYSTEM_ENVIRONMENT_PATH
        DOC "The directory where uwebsockets includes reside")

find_library(uwebsockets_LIBRARY
        NAMES uSockets.a
        PATHS ${UWEBSOCKETS_LIB_PATH}
        NO_CMAKE_SYSTEM_PATH
        NO_SYSTEM_ENVIRONMENT_PATH
        DOC "The uwebsockets library")

if (uwebsockets_INCLUDE_DIR AND uwebsockets_LIBRARY)
    include(FindPackageHandleStandardArgs)
    find_package_handle_standard_args(uwebsockets DEFAULT_MSG
            uwebsockets_INCLUDE_DIR uwebsockets_LIBRARY)
    if (uwebsockets_FOUND)
        add_library(uwebsockets::uwebsockets STATIC IMPORTED)
        set_target_properties(uwebsockets::uwebsockets PROPERTIES
                INTERFACE_INCLUDE_DIRECTORIES "${uwebsockets_INCLUDE_DIR}"
                IMPORTED_LINK_INTERFACE_LANGUAGES "CXX"
                IMPORTED_LOCATION "${uwebsockets_LIBRARY}")
    endif ()
endif ()