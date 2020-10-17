set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/../cmake)
include(Versions)
find_package(rdkafka REQUIRED QUIET)

if (RdKafka_FOUND)
    message("-- Found rdkafka library.")
    add_library(rdkafka_external INTERFACE)
else ()
    set(EXTERNAL_INSTALL_LOCATION ${STAGED_INSTALL_PREFIX}/rdkafka)
    include(ExternalProject)
    ExternalProject_Add(rdkafka_external
            PREFIX
                ${EXTERNAL_INSTALL_LOCATION}
            GIT_REPOSITORY
                ${RDKAFKA_URL}
            GIT_TAG
                ${RDKAFKA_TAG}
            GIT_SUBMODULES_RECURSE
                1
            GIT_SHALLOW
                1
            GIT_PROGRESS
                1
            LOG_CONFIGURE
                1
            LOG_BUILD
                1
            LOG_INSTALL
                1
            LOG_DOWNLOAD
                1
            UPDATE_COMMAND
                ${CMAKE_NOOP}
            CONFIGURE_COMMAND
                <SOURCE_DIR>/configure --prefix=${EXTERNAL_INSTALL_LOCATION} --install-deps --enable-static
            BUILD_COMMAND
                make -j4
            BUILD_IN_SOURCE
                1
            INSTALL_COMMAND
                make -C <SOURCE_DIR> install prefix=${EXTERNAL_INSTALL_LOCATION})
    set(RdKafka_ROOT ${EXTERNAL_INSTALL_LOCATION}
            CACHE PATH "Path to internally built rdkafka installation root"
            FORCE)
    set(RdKafka_INCLUDE_DIR ${RdKafka_ROOT}/include
            CACHE PATH "Path to internally built rdkafka include directories"
            FORCE)
    set(RdKafka_LIBRARY_PATH ${RdKafka_ROOT}/lib
            CACHE PATH "Path to internally built rdkafka library directories"
            FORCE)
    set(RdKafka_CONFIG_DIR ${RdKafka_ROOT}
            CACHE PATH "Path to internally built rdkafka library config directories"
            FORCE)
    # Unset internal variables
    unset(EXTERNAL_INSTALL_LOCATION)
endif ()