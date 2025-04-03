// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ErrorManager",
    platforms: [
        .iOS(.v15),
        .macOS(.v12)
    ],
    products: [
        .library(
            name: "ErrorManager",
            targets: ["ErrorManager"]),
    ],
    targets: [
        .target(
            name: "ErrorManager"),

    ]
)
