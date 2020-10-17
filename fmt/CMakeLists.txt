set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/../cmake)
include(Versions)
find_package(fmt REQUIRED QUIET)

if (fmt_FOUND)
    message("-- Found fmt library.")
    add_library(fmt_external INTERFACE)
else()
    message(STATUS "Fmt TAG: ${FMT_TAG} could not be located.")
    include(ExternalProject)
    set(EXTERNAL_INSTALL_LOCATION ${STAGED_INSTALL_PREFIX}/fmt)
    ExternalProject_Add(fmt_external
            PREFIX
                ${EXTERNAL_INSTALL_LOCATION}
            GIT_REPOSITORY
                ${FMT_URL}
            GIT_TAG
                ${FMT_TAG}
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
                -DCMAKE_INSTALL_PREFIX=${EXTERNAL_INSTALL_LOCATION}
                -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
                -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}
            CMAKE_CACHE_ARGS
                -DCMAKE_CXX_FLAGS:STRING=${CMAKE_CXX_FLAGS})
    set(FMT_ROOT ${EXTERNAL_INSTALL_LOCATION}
            CACHE PATH "Path to internally built fmt installation root"
            FORCE)
    set(FMT_INCLUDE_DIR ${FMT_ROOT}/include
            CACHE PATH "Path to internally built fmt include directories"
            FORCE)
    set(FMT_LIB_PATH ${FMT_ROOT}/lib
            CACHE PATH "Path to internally built fmt library directories"
            FORCE)
    set(FMT_CONFIG_DIR ${FMT_LIB_PATH}/cmake/fmt
            CACHE PATH "Path to internally built fmt library config directories"
            FORCE)
    # Unset internal variables
    unset(EXTERNAL_INSTALL_LOCATION)
endif ()

