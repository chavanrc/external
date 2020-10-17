set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/../cmake)
include(Versions)
find_package(libevent REQUIRED QUIET)

if (libevent_FOUND)
    message("-- Found libevent library.")
    add_library(libevent_external INTERFACE)
else ()
    message(STATUS "libevent TAG: ${LIBEVENT_TAG} could not be located.")
    include(ExternalProject)
    set(EXTERNAL_INSTALL_LOCATION ${STAGED_INSTALL_PREFIX}/libevent)
    ExternalProject_Add(libevent_external
            PREFIX
                ${EXTERNAL_INSTALL_LOCATION}
            GIT_REPOSITORY
                ${LIBEVENT_URL}
            GIT_TAG
                ${LIBEVENT_TAG}
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
            CMAKE_ARGS
                -DCMAKE_INSTALL_PREFIX:PATH=${EXTERNAL_INSTALL_LOCATION}
                -DCMAKE_BUILD_TYPE:STRING=${CMAKE_BUILD_TYPE}
                -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}
                -DEVENT__DISABLE_BENCHMARK=ON
                -DEVENT__DISABLE_TESTS=ON
                -DEVENT__DISABLE_SAMPLES=ON
                -DEVENT__LIBRARY_TYPE=STATIC
            CMAKE_CACHE_ARGS
                -DCMAKE_CXX_FLAGS:STRING=${CMAKE_CXX_FLAGS})
    set(LIBEVENT_ROOT ${EXTERNAL_INSTALL_LOCATION}
            CACHE PATH "Path to internally built libevent installation root"
            FORCE)
    set(LIBEVENT_INCLUDE_DIR ${LIBEVENT_ROOT}/include
            CACHE PATH "Path to internally built libevent include directories"
            FORCE)
    set(LIBEVENT_LIB_PATH ${LIBEVENT_ROOT}/lib
            CACHE PATH "Path to internally built libevent library directories"
            FORCE)
    set(LIBEVENT_CONFIG_DIR ${LIBEVENT_LIB_PATH}/cmake/libevent
            CACHE PATH "Path to internally built libevent library config directories"
            FORCE)
    # Unset internal variables
    unset(EXTERNAL_INSTALL_LOCATION)
endif ()