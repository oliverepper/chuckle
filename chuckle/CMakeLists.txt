add_library(
        chuckle
        STATIC
        chuckle.cpp
        $<TARGET_OBJECTS:cpr>
        $<TARGET_OBJECTS:libcurl>
        $<TARGET_OBJECTS:zlib>
)

target_link_libraries(chuckle PRIVATE ${CPR_LIBRARIES} nlohmann_json::nlohmann_json)







