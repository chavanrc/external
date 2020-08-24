set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/../cmake)
include(Versions)
find_package(nlohmann REQUIRED QUIET)

if (nlohmann_FOUND)
    message("-- Found nlohmann library.")
    add_library(nlohmann_external INTERFACE)
else ()
    message(STATUS "Nlohmann TAG: ${NLOHMANN_TAG} could not be located.")
    include(ExternalProject)
    set(EXTERNAL_INSTALL_LOCATION ${STAGED_INSTALL_PREFIX}/nlohmann)
    ExternalProject_Add(nlohmann_external
            PREFIX
                ${EXTERNAL_INSTALL_LOCATION}
            GIT_REPOSITORY
                ${NLOHMANN_URL}
            GIT_TAG
                ${NLOHMANN_TAG}
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
    set(NLOHMANN_ROOT ${EXTERNAL_INSTALL_LOCATION}
            CACHE PATH "Path to internally built nlohmann installation root"
            FORCE)
    set(NLOHMANN_INCLUDE_DIR ${NLOHMANN_ROOT}/include
            CACHE PATH "Path to internally built nlohmann include directories"
            FORCE)
    set(NLOHMANN_LIB_PATH ${NLOHMANN_ROOT}/lib
            CACHE PATH "Path to internally built nlohmann library directories"
            FORCE)
    set(NLOHMANN_CONFIG_DIR ${NLOHMANN_LIB_PATH}/cmake/nlohmann_json
            CACHE PATH "Path to internally built nlohmann library config directories"
            FORCE)
    # Unset internal variables
    unset(EXTERNAL_INSTALL_LOCATION)
endif ()