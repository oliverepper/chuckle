target_include_directories(
        chuckle
        PUBLIC
        $<INSTALL_INTERFACE:include>
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
)

target_sources(chuckle PRIVATE chuckle/chuckle.h)