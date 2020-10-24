set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/../cmake)
include(Versions)
find_package(snappy REQUIRED QUIET)

if (snappy_FOUND)
    message("-- Found snappy library.")
    add_library(snappy_external INTERFACE)
else ()
    message(STATUS "snappy TAG: ${SNAPPY_TAG} could not be located.")
    include(ExternalProject)
    set(EXTERNAL_INSTALL_LOCATION ${STAGED_INSTALL_PREFIX}/snappy)
    ExternalProject_Add(snappy_external
            PREFIX
                ${EXTERNAL_INSTALL_LOCATION}
            GIT_REPOSITORY
                ${SNAPPY_URL}
            GIT_TAG
                ${SNAPPY_TAG}
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
            CMAKE_CACHE_ARGS
                -DCMAKE_CXX_FLAGS:STRING=${CMAKE_CXX_FLAGS})
    set(SNAPPY_ROOT ${EXTERNAL_INSTALL_LOCATION}
            CACHE PATH "Path to internally built snappy installation root"
            FORCE)
    set(SNAPPY_INCLUDE_DIR ${SNAPPY_ROOT}/include
            CACHE PATH "Path to internally built snappy include directories"
            FORCE)
    set(SNAPPY_LIB_PATH ${SNAPPY_ROOT}/lib
            CACHE PATH "Path to internally built snappy library directories"
            FORCE)
    set(SNAPPY_CONFIG_DIR ${SNAPPY_LIB_PATH}/cmake/Snappy
            CACHE PATH "Path to internally built snappy library config directories"
            FORCE)
    # Unset internal variables
    unset(EXTERNAL_INSTALL_LOCATION)
endif ()