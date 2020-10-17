set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/../cmake)
include(Versions)
find_package(cppkafka REQUIRED QUIET)

if (cppkafka_FOUND)
    message("-- Found cppkafka library.")
    add_library(cppkafka_external INTERFACE)
else ()
    message(STATUS "Cppkafka TAG: ${CPPKAFKA_TAG} could not be located.")
    include(ExternalProject)
    set(EXTERNAL_INSTALL_LOCATION ${STAGED_INSTALL_PREFIX}/cppkafka)
    ExternalProject_Add(cppkafka_external
            DEPENDS
                boost_external
                rdkafka_external
            PREFIX
                ${EXTERNAL_INSTALL_LOCATION}
            GIT_REPOSITORY
                ${CPPKAFKA_URL}
            GIT_TAG
                ${CPPKAFKA_TAG}
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
                git apply ${CMAKE_CURRENT_LIST_DIR}/0001-Added-sasl2-dependency.patch
            CMAKE_ARGS
                -DCMAKE_INSTALL_PREFIX=${EXTERNAL_INSTALL_LOCATION}
                -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
                -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}
                -DCPPKAFKA_RDKAFKA_STATIC_LIB=ON
                -DCPPKAFKA_DISABLE_TESTS=ON
                -DCPPKAFKA_DISABLE_EXAMPLES=ON
                -DCPPKAFKA_BUILD_SHARED=OFF
                -DRDKAFKA_ROOT=${RdKafka_ROOT}
                -DBoost_NO_BOOST_CMAKE=TRUE
                -DBoost_NO_SYSTEM_PATHS=TRUE
                -DBOOST_ROOT:FILEPATH=${BOOST_ROOT}
                -DBoost_LIBRARY_DIRS:FILEPATH=${BOOST_LIB_PATH}
                -DCMAKE_PREFIX_PATH=${BOOST_INCLUDE_DIR};${RdKafka_INCLUDE_DIR}
                -DCMAKE_LIBRARY_PATH=${BOOST_LIB_PATH};${RdKafka_LIBRARY_PATH}
                -Wno-dev
            CMAKE_CACHE_ARGS
                -DCMAKE_CXX_FLAGS:STRING=${CMAKE_CXX_FLAGS}
                -DCMAKE_INCLUDE_PATH:PATH=${BOOST_INCLUDE_DIR};${RdKafka_INCLUDE_DIR}
                -DCMAKE_LIBRARY_PATH:PATH=${BOOST_LIB_PATH};${RdKafka_LIBRARY_PATH})
    set(CppKafka_ROOT ${EXTERNAL_INSTALL_LOCATION}
            CACHE PATH "Path to internally built CppKafka installation root"
            FORCE)
    set(CppKafka_INCLUDE_DIR ${CppKafka_ROOT}/include
            CACHE PATH "Path to internally built CppKafka include directories"
            FORCE)
    set(CppKafka_LIB_PATH ${CppKafka_ROOT}/lib
            CACHE PATH "Path to internally built CppKafka library directories"
            FORCE)
    set(CppKafka_CONFIG_DIR ${CppKafka_LIB_PATH}/cmake/CppKafka
            CACHE PATH "Path to internally built CppKafka library config directories"
            FORCE)
    #ExternalProject_Add_Step(cppkafka_external after_install
    #        COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../cmake/CppKafkaConfig.cmake ${CppKafka_CONFIG_DIR}
    #        DEPENDEES install)
    # Unset internal variables
    unset(EXTERNAL_INSTALL_LOCATION)
endif ()