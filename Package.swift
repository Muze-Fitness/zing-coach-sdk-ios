// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "ZingCoach",
    platforms: [.iOS(.v16)],
    products: [
        .library(name: "ZingCoach", targets: ["ZingCoach"])
    ],
    dependencies: [
        .package(url: "https://github.com/Muze-Fitness/zing-coach-ios-tools", exact: "1.2.0"),
        .package(url: "https://github.com/Muze-Fitness/zing-coach-sdk-ios-dynamic-dependencies.git", exact: "1.0.1"),
        .package(url: "https://github.com/airbnb/lottie-ios.git", .upToNextMajor(from: "4.5.1")),
        .package(url: "https://github.com/SnapKit/SnapKit.git", .upToNextMajor(from: "5.6.0")),
    ],
    targets: [
        .binaryTarget(
            name: "ZingCoachSDK",
            url: "https://github.com/Muze-Fitness/zing-coach-sdk-ios/releases/download/1.4.0/ZingCoachSDK.xcframework.zip",
            checksum: "26b082b607392899ee1fa71dc2a15e2810fa21bcdadb028f404f5f4657f37365"
        ),
        .target(
            name: "ZingCoach",
            dependencies: [
                .target(name: "ZingCoachSDK"),
                .product(name: "DesignSystem", package: "zing-coach-ios-tools"),
                .product(name: "ZingCoachDynamicDependencies", package: "zing-coach-sdk-ios-dynamic-dependencies"),
                .product(name: "Lottie-Dynamic", package: "lottie-ios"),
                .product(name: "SnapKit-Dynamic", package: "SnapKit"),
            ],
            path: "Sources/ZingCoach"
        ),
    ]
)
