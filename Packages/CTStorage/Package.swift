// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "CTStorage",
    platforms: [
        .macOS(.v14)
    ],
    products: [
        .library(name: "CTStorage", targets: ["CTStorage"])
    ],
    targets: [
        .target(name: "CTStorage"),
        .testTarget(name: "CTStorageTests", dependencies: ["CTStorage"])
    ]
)
