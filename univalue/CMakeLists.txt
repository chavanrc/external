set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/../cmake)
include(Versions)
find_package(univalue REQUIRED QUIET)

if (univalue_FOUND)
    message("-- Found univalue library.")
    add_library(univalue_external INTERFACE)
else ()
    message(STATUS "univalue TAG: ${UNIVALUE_TAG} could not be located.")
    include(ExternalProject)
    set(EXTERNAL_INSTALL_LOCATION ${STAGED_INSTALL_PREFIX}/univalue)
    ExternalProject_Add(univalue_external
            PREFIX
                ${EXTERNAL_INSTALL_LOCATION}
            GIT_REPOSITORY
                ${UNIVALUE_URL}
            GIT_TAG
                ${UNIVALUE_TAG}
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
                <SOURCE_DIR>/autogen.sh COMMAND <SOURCE_DIR>/configure --prefix=${EXTERNAL_INSTALL_LOCATION} --enable-shared=no
            BUILD_IN_SOURCE
                1
            BUILD_COMMAND
                $(MAKE)
            INSTALL_COMMAND
                $(MAKE) install prefix=${EXTERNAL_INSTALL_LOCATION})
    set(UNIVALUE_ROOT ${EXTERNAL_INSTALL_LOCATION}
            CACHE PATH "Path to internally built univalue installation root"
            FORCE)
    set(UNIVALUE_INCLUDE_DIR ${UNIVALUE_ROOT}/include
            CACHE PATH "Path to internally built univalue include directories"
            FORCE)
    set(UNIVALUE_LIB_PATH ${UNIVALUE_ROOT}/lib
            CACHE PATH "Path to internally built univalue library directories"
            FORCE)
    set(UNIVALUE_CONFIG_DIR ${UNIVALUE_ROOT}
            CACHE PATH "Path to internally built univalue library config directories"
            FORCE)
    # Unset internal variables
    unset(EXTERNAL_INSTALL_LOCATION)
endif ()