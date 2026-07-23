// swift-tools-version: 6.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "InAppPurchases",
    platforms: [
        .macOS(.v26),
        .iOS(.v26)
    ],
    products: [
        .library(
            name: "InAppPurchases",
            targets: ["InAppPurchases"]
        ),
    ],
    targets: [
        .target(
            name: "InAppPurchases"
        ),

    ],
    swiftLanguageModes: [.v6]
)
