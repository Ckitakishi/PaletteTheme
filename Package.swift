// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PaletteTheme",
    platforms: [.macOS(.v13)],
    products: [
        .library(
            name: "PaletteTheme",
            targets: ["PaletteTheme"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/johnsundell/publish.git",
            from: "0.9.0"
        ),
        .package(
            url: "https://github.com/johnsundell/splashpublishplugin",
            from: "0.2.0"
        ),
    ],
    targets: [
        .target(
            name: "PaletteTheme",
            dependencies: [
                .product(name: "Publish", package: "publish"),
                .product(name: "SplashPublishPlugin", package: "splashpublishplugin")
            ],
            path: "Sources"
        ),
        .testTarget(
            name: "PaletteThemeTests",
            dependencies: ["PaletteTheme"],
            path: "Tests"
        ),
    ]
)
