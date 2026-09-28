// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "ZingCoach",
    platforms: [.iOS(.v16)],
    products: [
        .library(name: "ZingCoach", targets: ["ZingCoach"])
    ],
    dependencies: [
        .package(url: "https://github.com/Muze-Fitness/zing-coach-ios-tools", exact: "1.7.0"),
        .package(url: "https://github.com/SnapKit/SnapKit.git", .upToNextMajor(from: "5.6.0")),
    ],
    targets: [
        .binaryTarget(
            name: "ZingCoachSDK",
            url: "https://github.com/Muze-Fitness/zing-coach-sdk-ios/releases/download/2.3.0/ZingCoachSDK.xcframework.zip",
            checksum: "e86e2cdc8b8983f8d644ba0d274a847a58313704c2055c71c76dee09a0f140d2"
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
