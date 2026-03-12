// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "CTDesignSystem",
    platforms: [
        .macOS(.v14)
    ],
    products: [
        .library(name: "CTDesignSystem", targets: ["CTDesignSystem"])
    ],
    targets: [
        .target(name: "CTDesignSystem"),
        .testTarget(name: "CTDesignSystemTests", dependencies: ["CTDesignSystem"])
    ]
)
