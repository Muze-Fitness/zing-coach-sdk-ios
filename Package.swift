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
            url: "https://github.com/Muze-Fitness/zing-coach-sdk-ios/releases/download/1.2.0/ZingCoachSDK.xcframework.zip",
            checksum: "1e94b210432fe23c1a534b0d112e1dbb568d0a7bd0ec190bc8f0a57808975e1d"
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
