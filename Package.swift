// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PaletteTheme",
    platforms: [.macOS(.v12)],
    products: [
        .library(
            name: "PaletteTheme",
            targets: ["PaletteTheme"]
        ),
    ],
    dependencies: [
        .package(
            name: "Publish",
            url: "https://github.com/johnsundell/publish.git",
            from: "0.7.0"
        ),
        .package(
            name: "SplashPublishPlugin",
            url: "https://github.com/johnsundell/splashpublishplugin",
            from: "0.1.0"
        ),
    ],
    targets: [
        .target(
            name: "PaletteTheme",
            dependencies: ["Publish", "SplashPublishPlugin"],
            path: "Sources",
            resources: [.copy("../Resources")]
        ),
        .testTarget(
            name: "PaletteThemeTests",
            dependencies: ["PaletteTheme"],
            path: "Tests"
        ),
    ]
)
