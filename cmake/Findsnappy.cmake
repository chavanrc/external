find_path(snappy_INCLUDE_DIR
        NAMES snappy.h
        PATHS ${SNAPPY_INCLUDE_DIR}
        NO_CMAKE_SYSTEM_PATH
        NO_SYSTEM_ENVIRONMENT_PATH
        DOC "The directory where snappy includes reside")

set(SNAPPY_LIBRARIES snappy)

find_library(snappy_LIBRARY
        NAMES ${SNAPPY_LIBRARIES}
        PATHS ${SNAPPY_LIB_PATH}
        NO_CMAKE_SYSTEM_PATH
        NO_SYSTEM_ENVIRONMENT_PATH
        DOC "The snappy library")

if (snappy_INCLUDE_DIR AND snappy_LIBRARY)
    include(FindPackageHandleStandardArgs)
    find_package_handle_standard_args(snappy DEFAULT_MSG
            snappy_INCLUDE_DIR snappy_LIBRARY)
    if (snappy_FOUND)
        add_library(snappy::snappy STATIC IMPORTED)
        set_target_properties(snappy::snappy PROPERTIES
                INTERFACE_INCLUDE_DIRECTORIES "${snappy_INCLUDE_DIR}"
                IMPORTED_LINK_INTERFACE_LANGUAGES "CXX"
                IMPORTED_LOCATION "${snappy_LIBRARY}")
    endif ()
endif ()