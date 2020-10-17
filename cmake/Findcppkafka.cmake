find_path(cppkafka_INCLUDE_DIR
        NAMES cppkafka/cppkafka.h
        PATHS ${CppKafka_INCLUDE_DIR}
        NO_CMAKE_SYSTEM_PATH
        NO_SYSTEM_ENVIRONMENT_PATH
        DOC "The directory where cppkafka includes reside")

find_library(cppkafka_LIBRARY
        NAMES cppkafka
        PATHS ${CppKafka_LIB_PATH}
        NO_CMAKE_SYSTEM_PATH
        NO_SYSTEM_ENVIRONMENT_PATH
        DOC "The cppkafka library")

if (cppkafka_INCLUDE_DIR AND cppkafka_LIBRARY)
    include(FindPackageHandleStandardArgs)
    find_package_handle_standard_args(cppkafka DEFAULT_MSG
            cppkafka_INCLUDE_DIR cppkafka_LIBRARY)
    if (cppkafka_FOUND)
        add_library(cppkafka::cppkafka STATIC IMPORTED)
        set_target_properties(cppkafka::cppkafka PROPERTIES
                INTERFACE_INCLUDE_DIRECTORIES "${cppkafka_INCLUDE_DIR}"
                IMPORTED_LINK_INTERFACE_LANGUAGES "CXX"
                IMPORTED_LOCATION "${cppkafka_LIBRARY}")
    endif ()
endif ()