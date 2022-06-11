// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "SafeDecodable",
    platforms: [.macOS(.v11), .iOS(.v14)],
    products: [
        .library(
            name: "SafeDecodable",
            targets: ["SafeDecodable"]
        ),
    ],
    targets: [
        .target(
            name: "SafeDecodable"),
        .testTarget(
            name: "SafeDecodableTests",
            dependencies: ["SafeDecodable"]
        ),
    ]
)
