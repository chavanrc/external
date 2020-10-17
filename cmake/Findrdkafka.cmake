find_path(rdkafka_INCLUDE_DIR
        NAMES librdkafka/rdkafka.h
        PATHS ${RdKafka_INCLUDE_DIR}
        NO_CMAKE_SYSTEM_PATH
        NO_SYSTEM_ENVIRONMENT_PATH
        DOC "The directory where rdkafka includes reside")

find_library(rdkafka_LIBRARY
        NAMES rdkafka
        PATHS ${RdKafka_LIBRARY_PATH}
        NO_CMAKE_SYSTEM_PATH
        NO_SYSTEM_ENVIRONMENT_PATH
        DOC "The rdkafka library")

find_library(rdkafka++_LIBRARY
        NAMES rdkafka++
        PATHS ${RdKafka_LIBRARY_PATH}
        NO_CMAKE_SYSTEM_PATH
        NO_SYSTEM_ENVIRONMENT_PATH
        DOC "The rdkafka++ library")

if (rdkafka_INCLUDE_DIR AND rdkafka_LIBRARY AND rdkafka++_LIBRARY)
    include(FindPackageHandleStandardArgs)
    find_package_handle_standard_args(RdKafka DEFAULT_MSG
            rdkafka_LIBRARY rdkafka++_LIBRARY rdkafka_INCLUDE_DIR)
    if (RdKafka_FOUND)
        find_package(Threads REQUIRED)
        find_package(ZLIB REQUIRED) # sudo apt install zlib1g-dev
        add_library(RdKafka::rdkafka STATIC IMPORTED GLOBAL)
        add_dependencies(RdKafka::rdkafka rdkafka_external)
        set_target_properties(RdKafka::rdkafka PROPERTIES
                INTERFACE_INCLUDE_DIRECTORIES ${rdkafka_INCLUDE_DIR}
                INTERFACE_LINK_LIBRARIES "Threads::Threads;${ZLIB_LIBRARIES}"
                IMPORTED_LOCATION ${rdkafka_LIBRARY})
    endif ()
endif ()