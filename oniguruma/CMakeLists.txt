set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/../cmake)
include(Versions)
find_package(oniguruma REQUIRED QUIET)

if (oniguruma_FOUND)
    message("-- Found oniguruma library.")
    add_library(oniguruma_external INTERFACE)
else ()
    message(STATUS "oniguruma TAG: ${ONIGURUMA_TAG} could not be located.")
    include(ExternalProject)
    set(EXTERNAL_INSTALL_LOCATION ${STAGED_INSTALL_PREFIX}/oniguruma)
    ExternalProject_Add(oniguruma_external
            PREFIX
                ${EXTERNAL_INSTALL_LOCATION}
            GIT_REPOSITORY
                ${ONIGURUMA_URL}
            GIT_TAG
                ${ONIGURUMA_TAG}
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
                ${CMAKE_NOOP}
            CMAKE_ARGS
                -DCMAKE_INSTALL_PREFIX:PATH=${EXTERNAL_INSTALL_LOCATION}
                -DCMAKE_BUILD_TYPE:STRING=${CMAKE_BUILD_TYPE}
                -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}
                -DBUILD_SHARED_LIBS=OFF
            CMAKE_CACHE_ARGS
                -DCMAKE_CXX_FLAGS:STRING=${CMAKE_CXX_FLAGS})
    set(ONIGURUMA_ROOT ${EXTERNAL_INSTALL_LOCATION}
            CACHE PATH "Path to internally built oniguruma installation root"
            FORCE)
    set(ONIGURUMA_INCLUDE_DIR ${ONIGURUMA_ROOT}/include
            CACHE PATH "Path to internally built oniguruma include directories"
            FORCE)
    set(ONIGURUMA_LIB_PATH ${ONIGURUMA_ROOT}/lib
            CACHE PATH "Path to internally built oniguruma library directories"
            FORCE)
    set(ONIGURUMA_CONFIG_DIR ${ONIGURUMA_LIB_PATH}/cmake/oniguruma
            CACHE PATH "Path to internally built oniguruma library config directories"
            FORCE)
    # Unset internal variables
    unset(EXTERNAL_INSTALL_LOCATION)
endif ()