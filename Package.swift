// swift-tools-version: 5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "STools",
    platforms: [
           .iOS(.v13),
           .macOS(.v10_13),
           .watchOS(.v6)
       ],
    products: [
        .library(
            name: "STools",
            targets: ["STools"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "STools",
            dependencies: []),
        .testTarget(
            name: "SToolsTests",
            dependencies: ["STools"]),
    ]
)
