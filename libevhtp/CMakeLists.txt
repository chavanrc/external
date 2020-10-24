set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/../cmake)
include(Versions)
find_package(libevhtp REQUIRED QUIET)

if (libevhtp_FOUND)
    message("-- Found libevhtp library.")
    add_library(libevhtp_external INTERFACE)
else ()
    message(STATUS "libevhtp TAG: ${LIBEVHTP_TAG} could not be located.")
    include(ExternalProject)
    set(EXTERNAL_INSTALL_LOCATION ${STAGED_INSTALL_PREFIX}/libevhtp)
    ExternalProject_Add(libevhtp_external
            DEPENDS
                libevent_external
            PREFIX
                ${EXTERNAL_INSTALL_LOCATION}
            GIT_REPOSITORY
                ${LIBEVHTP_URL}
            GIT_TAG
                ${LIBEVHTP_TAG}
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
            PATCH_COMMAND
                git apply ${CMAKE_CURRENT_LIST_DIR}/Find_config.patch
            CMAKE_ARGS
                -DCMAKE_INSTALL_PREFIX:PATH=${EXTERNAL_INSTALL_LOCATION}
                -DCMAKE_BUILD_TYPE:STRING=${CMAKE_BUILD_TYPE}
                -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}
                -Wno-dev
                -DBUILD_SHARED_LIBS=OFF
            CMAKE_CACHE_ARGS
                -DCMAKE_CXX_FLAGS:STRING=${CMAKE_CXX_FLAGS}
                -DCMAKE_PREFIX_PATH:PATH=${LIBEVENT_CONFIG_DIR})
    set(LIBEVHTP_ROOT ${EXTERNAL_INSTALL_LOCATION}
            CACHE PATH "Path to internally built libevhtp installation root"
            FORCE)
    set(LIBEVHTP_INCLUDE_DIR ${LIBEVHTP_ROOT}/include
            CACHE PATH "Path to internally built libevhtp include directories"
            FORCE)
    set(LIBEVHTP_LIB_PATH ${LIBEVHTP_ROOT}/lib
            CACHE PATH "Path to internally built libevhtp library directories"
            FORCE)
    set(LIBEVHTP_CONFIG_DIR ${LIBEVHTP_ROOT}
            CACHE PATH "Path to internally built libevhtp library config directories"
            FORCE)
    # Unset internal variables
    unset(EXTERNAL_INSTALL_LOCATION)
endif ()