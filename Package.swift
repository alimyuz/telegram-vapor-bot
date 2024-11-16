// swift-tools-version:5.8

import PackageDescription

let name: String = "SwiftTelegramSdk"

let package = Package(
    name: name,
    platforms: [
        .macOS(.v12),
        .ios(.v13),
    ],
    products: [
        .library(
            name: name,
            targets: [name]),
    ],
    dependencies: [
        .package(url: "https://github.com/nerzh/swift-regular-expression", .upToNextMajor(from: "0.2.4")),
        .package(url: "https://github.com/nerzh/swift-custom-logger", .upToNextMajor(from: "1.1.0")),
        .package(url: "https://github.com/apple/swift-crypto.git", .upToNextMajor(from: "3.8.0")),
    ],
    targets: [
        .target(
            name: name,
            dependencies: [
                .product(name: "SwiftRegularExpression", package: "swift-regular-expression"),
                .product(name: "SwiftCustomLogger", package: "swift-custom-logger"),
                .product(name: "Crypto", package: "swift-crypto"),
            ]
        )
    ]
)
