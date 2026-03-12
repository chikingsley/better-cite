// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "CTDataLocal",
    platforms: [
        .macOS(.v14)
    ],
    products: [
        .library(name: "CTDataLocal", targets: ["CTDataLocal"])
    ],
    dependencies: [
        .package(path: "../CTCommon"),
        .package(path: "../CTDomain")
    ],
    targets: [
        .target(
            name: "CTDataLocal",
            dependencies: [
                "CTCommon",
                "CTDomain"
            ]
        ),
        .testTarget(
            name: "CTDataLocalTests",
            dependencies: ["CTDataLocal"]
        )
    ]
)
