// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ada-swiftpm",
    products: [
        .executable(
            name: "Ada-SwiftPM",
            targets: ["ada-swiftpm"]
        ),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
         .package(url: "https://github.com/JohnSundell/Files.git", from: "2.2.1"),
         .package(url: "https://github.com/kylef/Commander.git", .branch("master")),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "ada-swiftpm",
            dependencies: ["Files", "Commander"]),
        .testTarget(
            name: "ada-swiftpmTests",
            dependencies: ["ada-swiftpm"]),
    ]
)
