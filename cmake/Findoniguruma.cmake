find_path(oniguruma_INCLUDE_DIR
        NAMES oniguruma/oniguruma.h
        PATHS ${ONIGURUMA_INCLUDE_DIR}
        NO_CMAKE_SYSTEM_PATH
        NO_SYSTEM_ENVIRONMENT_PATH
        DOC "The directory where oniguruma includes reside")


set(ONIGURUMA_LIBRARIES oniguruma)

find_library(oniguruma_LIBRARY
        NAMES ${ONIGURUMA_LIBRARIES}
        PATHS ${ONIGURUMA_LIB_PATH}
        NO_CMAKE_SYSTEM_PATH
        NO_SYSTEM_ENVIRONMENT_PATH
        DOC "The oniguruma library")

if (oniguruma_INCLUDE_DIR AND oniguruma_LIBRARY)
    include(FindPackageHandleStandardArgs)
    find_package_handle_standard_args(oniguruma DEFAULT_MSG
            oniguruma_INCLUDE_DIR oniguruma_LIBRARY)
    if (oniguruma_FOUND)
        add_library(oniguruma::oniguruma STATIC IMPORTED)
        set_target_properties(oniguruma::oniguruma PROPERTIES
                INTERFACE_INCLUDE_DIRECTORIES "${oniguruma_INCLUDE_DIR}"
                IMPORTED_LINK_INTERFACE_LANGUAGES "CXX"
                IMPORTED_LOCATION "${oniguruma_LIBRARY}")
    endif ()
endif ()