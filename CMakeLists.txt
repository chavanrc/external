cmake_minimum_required(VERSION 3.17 FATAL_ERROR)

project(external LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

if (NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Release CACHE STRING "Build type" FORCE)
endif ()

message(STATUS "Build type set to ${CMAKE_BUILD_TYPE}")

set(CMAKE_NOOP ${CMAKE_COMMAND} -E echo)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)
include(Versions)
include(GNUInstallDirs)
set_property(DIRECTORY PROPERTY EP_BASE ${CMAKE_BINARY_DIR}/subprojects)

set(STAGED_INSTALL_PREFIX ${CMAKE_BINARY_DIR}/stage)
message(STATUS "${PROJECT_NAME} staged install: ${STAGED_INSTALL_PREFIX}")

set(Boost_MINIMUM_REQUIRED ${BOOST_VERSION})
add_subdirectory(boost)

add_subdirectory(catch)

add_subdirectory(spdlog)

add_subdirectory(univalue)

add_subdirectory(libevent)

add_subdirectory(libevhtp)

add_subdirectory(rdkafka)

add_subdirectory(cppkafka)

add_subdirectory(fmt)

add_subdirectory(snappy)

include(ExternalProject)
ExternalProject_Add(dummy
        DEPENDS
            boost_external
            catch_external
            spdlog_external
            univalue_external
            libevent_external
            libevhtp_external
            rdkafka_external
            cppkafka_external
            fmt_external
            snappy_external
        SOURCE_DIR
            ${CMAKE_CURRENT_LIST_DIR}/src
        CMAKE_ARGS
            -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}
            -DCMAKE_CXX_STANDARD=${CMAKE_CXX_STANDARD}
            -DCMAKE_CXX_EXTENSIONS=${CMAKE_CXX_EXTENSIONS}
            -DCMAKE_CXX_STANDARD_REQUIRED=${CMAKE_CXX_STANDARD_REQUIRED}
        CMAKE_CACHE_ARGS
            -DCMAKE_CXX_FLAGS:STRING=${CMAKE_CXX_FLAGS}
            -DCMAKE_PREFIX_PATH:PATH=${CMAKE_PREFIX_PATH};
                                     ${SPDLOG_CONFIG_DIR};
            -DCMAKE_INCLUDE_PATH:PATH=${SPDLOG_INCLUDE_DIR};
            -DCMAKE_LIBRARY_PATH:PATH=${SPDLOG_LIB_PATH};
        BUILD_ALWAYS
            1
        INSTALL_COMMAND
            ${CMAKE_NOOP})
