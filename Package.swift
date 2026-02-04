// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "ZingCoach",
    platforms: [.iOS(.v16)],
    products: [
        .library(name: "ZingCoach", targets: ["ZingCoach"])
    ],
    dependencies: [
        .package(
            url: "https://github.com/Muze-Fitness/zing-coach-sdk-ios-dynamic-dependencies.git",
            branch: "main"
        ),
        .package(url: "https://github.com/airbnb/lottie-ios.git", .upToNextMajor(from: "4.5.1")),
        .package(url: "https://github.com/SnapKit/SnapKit.git", .upToNextMajor(from: "5.6.0")),
    ],
    targets: [
        .binaryTarget(
            name: "ZingCoachSDK",
            url: "https://github.com/Muze-Fitness/zing-coach-sdk-ios/releases/download/1.0.1/ZingCoachSDK.xcframework.zip",
            checksum: "f2a765f63103db9cf39ce6bcd7ad9be619905580fd9a682351ef82310dbf29cf"
        ),
        .target(
            name: "ZingCoach",
            dependencies: [
                .target(name: "ZingCoachSDK"),
                .product(name: "Lottie-Dynamic", package: "lottie-ios"),
                .product(name: "SnapKit-Dynamic", package: "SnapKit"),
                .product(name: "ZingCoachDynamicDependencies", package: "zing-coach-sdk-ios-dynamic-dependencies"),
            ],
            path: "Sources/ZingCoach"
        ),
    ]
)
