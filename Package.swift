// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ada-swiftpm",
    products: [
        .executable(
            name: "swift-ada",
            targets: ["swift-ada"]
        ),
        .library(name: "AdaManifestDescription", type: .dynamic, targets: ["AdaManifestDescription"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
         .package(url: "https://github.com/JohnSundell/Files.git", from: "2.2.1"),
         .package(url: "https://github.com/kylef/Commander.git", .branch("master")),
         .package(url: "https://github.com/apple/swift-package-manager.git", .branch("master")),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "swift-ada",
            dependencies: ["Files", "Commander"]),
        .target(
            name: "AdaManifestDescription",
            dependencies: []),
        .testTarget(
            name: "swift-adaTests",
            dependencies: ["swift-ada"]),
    ]
)
