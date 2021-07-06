// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "ChuckleWrapper",
    platforms: [
        .iOS(.v14),
        .macOS(.v11)
    ],
    products: [
        .library(
            name: "ChuckleWrapper",
            targets: [
                "libchuckle",
                "ObjC",
                "ChuckleWrapper"
            ]),
    ],
    dependencies: [
    ],
    targets: [
        // lib
        .binaryTarget(
            name: "libchuckle",
            path: "lib/libchuckle.xcframework"
        ),

        // ObjC++ Wrapper
        .target(
            name: "ObjC",
            dependencies: [
                "libchuckle"
            ],
            path: "Sources/ObjC",
            cxxSettings: [
                .headerSearchPath("../../lib/libchuckle.xcframework/Headers")
            ]
        ),

        .target(
            name: "ChuckleWrapper",
            dependencies: [
                "ObjC"
            ],
            path: "Sources/Swift"
        ),

        .testTarget(
            name: "ChuckleWrapperTests",
            dependencies: ["ChuckleWrapper"]),
    ]
)
