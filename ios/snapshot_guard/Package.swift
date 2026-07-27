// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "snapshot_guard",
    platforms: [
        .iOS("12.0")
    ],
    products: [
        .library(name: "snapshot-guard", targets: ["snapshot_guard"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "snapshot_guard",
            dependencies: []
        )
    ]
)
