// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "CitrationMac",
    platforms: [
        .macOS(.v14)
    ],
    products: [
        .executable(name: "CitrationMac", targets: ["CitrationMac"])
    ],
    dependencies: [
        .package(path: "../../Packages/CTCommon"),
        .package(path: "../../Packages/CTDataLocal"),
        .package(path: "../../Packages/CTDataRemote"),
        .package(path: "../../Packages/CTStorage"),
        .package(path: "../../Packages/CTMetadataProviders"),
        .package(path: "../../Packages/CTCitationEngine"),
        .package(path: "../../Packages/CTDomain"),
        .package(path: "../../Packages/CTDesignSystem"),
        .package(url: "https://github.com/krzysztofzablocki/Inject.git", from: "1.2.4")
    ],
    targets: [
        .executableTarget(
            name: "CitrationMac",
            dependencies: [
                "CTCommon",
                "CTDataLocal",
                "CTDataRemote",
                "CTStorage",
                "CTMetadataProviders",
                "CTCitationEngine",
                "CTDomain",
                "CTDesignSystem",
                .product(name: "Inject", package: "Inject")
            ],
            linkerSettings: [
                .unsafeFlags([
                    "-Xlinker", "-sectcreate",
                    "-Xlinker", "__TEXT",
                    "-Xlinker", "__info_plist",
                    "-Xlinker", "Config/CitrationMac-Info.plist"
                ]),
                .unsafeFlags(["-Xlinker", "-interposable"], .when(configuration: .debug))
            ]
        ),
        .testTarget(
            name: "CitrationMacTests",
            dependencies: [
                "CitrationMac",
                "CTMetadataProviders",
                "CTCommon"
            ]
        )
    ]
)
