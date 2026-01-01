// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "sqlite-bridge",
    platforms: [
            .macOS(.v10_15)  // or higher
        ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "sqlite-bridge",
            targets: ["sqlite-bridge"]
        )
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "CSQLite",
            path: "Sources/CSQLite",
            publicHeadersPath: ".",
            cSettings: [
                .unsafeFlags(["-Wno-ambiguous-macro"])
            ]
        ),
        .target(
            name: "sqlite-bridge",
            dependencies: ["CSQLite"],
            path: "Sources/sqlite-bridge"
        ),
        .testTarget(
            name: "sqlite-bridgeTests",
            dependencies: ["sqlite-bridge"]
        ),
    ]
)
