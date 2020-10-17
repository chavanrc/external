find_path(univalue_INCLUDE_DIR
        NAMES univalue.h
        PATHS ${UNIVALUE_INCLUDE_DIR}
        NO_CMAKE_SYSTEM_PATH
        NO_SYSTEM_ENVIRONMENT_PATH
        DOC "The directory where univalue includes reside")

set(UNIVALUE_LIBRARIES univalue)

find_library(univalue_LIBRARY
        NAMES ${UNIVALUE_LIBRARIES}
        PATHS ${UNIVALUE_LIB_PATH}
        NO_CMAKE_SYSTEM_PATH
        NO_SYSTEM_ENVIRONMENT_PATH
        DOC "The univalue library")

if (univalue_INCLUDE_DIR AND univalue_LIBRARY)
    include(FindPackageHandleStandardArgs)
    find_package_handle_standard_args(univalue DEFAULT_MSG
            univalue_INCLUDE_DIR univalue_LIBRARY)
    if (univalue_FOUND)
        add_library(univalue::univalue STATIC IMPORTED)
        set_target_properties(univalue::univalue PROPERTIES
                INTERFACE_INCLUDE_DIRECTORIES "${univalue_INCLUDE_DIR}"
                IMPORTED_LINK_INTERFACE_LANGUAGES "CXX"
                IMPORTED_LOCATION "${univalue_LIBRARY}")
    endif ()
endif ()