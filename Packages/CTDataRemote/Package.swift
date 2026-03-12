// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "CTDataRemote",
    platforms: [
        .macOS(.v14)
    ],
    products: [
        .library(name: "CTDataRemote", targets: ["CTDataRemote"])
    ],
    targets: [
        .target(name: "CTDataRemote"),
        .testTarget(name: "CTDataRemoteTests", dependencies: ["CTDataRemote"])
    ]
)
