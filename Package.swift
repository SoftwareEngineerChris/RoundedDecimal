// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "RoundedDecimal",
    products: [
        .library(
            name: "RoundedDecimal",
            type: .static,
            targets: ["RoundedDecimal"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "RoundedDecimal",
            dependencies: []),
        .testTarget(
            name: "RoundedDecimalTests",
            dependencies: ["RoundedDecimal"]),
    ]
)
