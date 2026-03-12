// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "CTDomain",
    platforms: [
        .macOS(.v14)
    ],
    products: [
        .library(name: "CTDomain", targets: ["CTDomain"])
    ],
    dependencies: [
        .package(path: "../CTCommon")
    ],
    targets: [
        .target(name: "CTDomain", dependencies: ["CTCommon"]),
        .testTarget(name: "CTDomainTests", dependencies: ["CTDomain", "CTCommon"])
    ]
)
