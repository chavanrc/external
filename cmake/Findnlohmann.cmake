find_path(nlohmann_INCLUDE_DIR
        NAMES nlohmann/json.hpp
        PATHS ${NLOHMANN_INCLUDE_DIR}
        NO_CMAKE_SYSTEM_PATH
        NO_SYSTEM_ENVIRONMENT_PATH
        DOC "The directory where nlohmann includes reside")

if (nlohmann_INCLUDE_DIR)
    include(FindPackageHandleStandardArgs)
    find_package_handle_standard_args(nlohmann DEFAULT_MSG
            nlohmann_INCLUDE_DIR)
endif ()