// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "ZingCoach",
    platforms: [.iOS(.v16)],
    products: [
        .library(name: "ZingCoach", targets: ["ZingCoach"])
    ],
    dependencies: [
        .package(url: "https://github.com/Muze-Fitness/zing-coach-ios-tools", exact: "1.6.0"),
        .package(url: "https://github.com/SnapKit/SnapKit.git", .upToNextMajor(from: "5.6.0")),
    ],
    targets: [
        .binaryTarget(
            name: "ZingCoachSDK",
            url: "https://github.com/Muze-Fitness/zing-coach-sdk-ios/releases/download/2.2.0/ZingCoachSDK.xcframework.zip",
            checksum: "37337594a8654c1187d1785933ac9afb630ff3224720d8c76e935ebdd29c5dfa"
        ),
        .target(
            name: "ZingCoach",
            dependencies: [
                .target(name: "ZingCoachSDK"),
                .product(name: "DesignSystem", package: "zing-coach-ios-tools"),
                .product(name: "LottieAdapter", package: "zing-coach-ios-tools"),
                .product(name: "SnapKit-Dynamic", package: "SnapKit"),
            ],
            path: "Sources/ZingCoach"
        ),
    ]
)
