// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "CTCitationEngine",
    platforms: [
        .macOS(.v14)
    ],
    products: [
        .library(name: "CTCitationEngine", targets: ["CTCitationEngine"])
    ],
    targets: [
        .target(name: "CTCitationEngine"),
        .testTarget(name: "CTCitationEngineTests", dependencies: ["CTCitationEngine"])
    ]
)
