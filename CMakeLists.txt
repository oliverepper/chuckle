cmake_minimum_required(VERSION 3.19)
project(chuckle)

set(CMAKE_CXX_STANDARD 17)

set(CPR_BUILD_TESTS OFF)
set(CPR_BUILD_TESTS_SSL OFF)

include(FetchContent)
FetchContent_Declare(
        cpr
        GIT_REPOSITORY
        https://github.com/whoshuu/cpr.git
        GIT_TAG 1.6.2)
FetchContent_MakeAvailable(cpr)

FetchContent_Declare(json
        GIT_REPOSITORY https://github.com/ArthurSonzogni/nlohmann_json_cmake_fetchcontent
        GIT_TAG v3.7.3)
FetchContent_GetProperties(json)
if(NOT json_POPULATED)
    FetchContent_Populate(json)
    add_subdirectory(${json_SOURCE_DIR} ${json_BINARY_DIR} EXCLUDE_FROM_ALL)
endif()

add_subdirectory(chuckle)
add_subdirectory(include)
add_subdirectory(cli)