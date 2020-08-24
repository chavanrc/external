set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/../cmake)
include(Versions)
find_package(uwebsockets REQUIRED QUIET)

if (uwebsockets_FOUND)
    message("-- Found uWebsockets library.")
    add_library(uwebsockets_external INTERFACE)
else ()
    message(STATUS "uWebsockets TAG: ${UWEBSOCKETS_TAG} could not be located.")
    include(ExternalProject)
    set(EXTERNAL_INSTALL_LOCATION ${STAGED_INSTALL_PREFIX}/uwebsockets)
    ExternalProject_Add(uwebsockets_external
            PREFIX
                ${EXTERNAL_INSTALL_LOCATION}
            GIT_REPOSITORY
                ${UWEBSOCKETS_URL}
            GIT_TAG
                ${UWEBSOCKETS_TAG}
            GIT_PROGRESS
                1
            GIT_SHALLOW
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
                ${CMAKE_NOOP}
            BUILD_COMMAND
                make -C <SOURCE_DIR>
            COMMAND
                ${CMAKE_COMMAND} -E make_directory ${EXTERNAL_INSTALL_LOCATION}/include
            COMMAND
                ${CMAKE_COMMAND} -E copy <SOURCE_DIR>/uSockets/src/libusockets.h ${EXTERNAL_INSTALL_LOCATION}/include/
            COMMAND
                ${CMAKE_COMMAND} -E make_directory ${EXTERNAL_INSTALL_LOCATION}/lib
            COMMAND
                ${CMAKE_COMMAND} -E copy <SOURCE_DIR>/uSockets/uSockets.a ${EXTERNAL_INSTALL_LOCATION}/lib/
            INSTALL_COMMAND
                make -C <SOURCE_DIR> install prefix=${EXTERNAL_INSTALL_LOCATION})
    set(UWEBSOCKETS_ROOT ${EXTERNAL_INSTALL_LOCATION}
            CACHE PATH "Path to internally built uwebsockets installation root"
            FORCE)
    set(UWEBSOCKETS_INCLUDE_DIR ${UWEBSOCKETS_ROOT}/include
            CACHE PATH "Path to internally built uwebsockets include directories"
            FORCE)
    set(UWEBSOCKETS_LIB_PATH ${UWEBSOCKETS_ROOT}/lib
            CACHE PATH "Path to internally built uwebsockets library directories"
            FORCE)
    # Unset internal variables
    unset(EXTERNAL_INSTALL_LOCATION)
endif ()