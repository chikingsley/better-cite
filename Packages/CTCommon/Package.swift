// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "CTCommon",
    platforms: [
        .macOS(.v14)
    ],
    products: [
        .library(name: "CTCommon", targets: ["CTCommon"])
    ],
    targets: [
        .target(name: "CTCommon"),
        .testTarget(name: "CTCommonTests", dependencies: ["CTCommon"])
    ]
)
