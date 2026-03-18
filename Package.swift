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
            .upToNextMajor(from: "1.0.1")
        ),
        .package(url: "https://github.com/airbnb/lottie-ios.git", .upToNextMajor(from: "4.5.1")),
        .package(url: "https://github.com/SnapKit/SnapKit.git", .upToNextMajor(from: "5.6.0")),
    ],
    targets: [
        .binaryTarget(
            name: "ZingCoachSDK",
            url: "https://github.com/Muze-Fitness/zing-coach-sdk-ios/releases/download/1.1.2/ZingCoachSDK.xcframework.zip",
            checksum: "f2fb54a5820a08bff1c00568e88d35107e0861c6ac63fe58ed9a663e43022a5f"
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
