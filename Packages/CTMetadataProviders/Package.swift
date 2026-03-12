// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "CTMetadataProviders",
    platforms: [
        .macOS(.v14)
    ],
    products: [
        .library(name: "CTMetadataProviders", targets: ["CTMetadataProviders"])
    ],
    dependencies: [
        .package(path: "../CTCommon")
    ],
    targets: [
        .target(name: "CTMetadataProviders", dependencies: ["CTCommon"]),
        .testTarget(name: "CTMetadataProvidersTests", dependencies: ["CTMetadataProviders", "CTCommon"])
    ]
)
