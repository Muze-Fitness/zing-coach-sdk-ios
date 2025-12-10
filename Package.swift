// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "ZingCoachSDK",
    platforms: [.iOS(.v16)],
    products: [
        .library(name: "ZingCoachSDK", targets: ["ZingCoachSDK"])
    ],
    dependencies: [
        .package(url: "https://github.com/airbnb/lottie-ios.git", .upToNextMajor(from: "4.5.1")),
        .package(url: "https://github.com/SnapKit/SnapKit.git", .upToNextMajor(from: "5.6.0")),
    ],
    targets: [
        .binaryTarget(
            name: "PrivateSDK",
            url: "https://api.github.com/repos/Muze-Fitness/zing-coach-sdk-ios/releases/assets/328058985.zip",
            checksum: "e2077f04353d26c31c82d56436ddd3b4931e32bcebbc32a51fd2009560cb46e9"
        ),
        .target(
            name: "ZingCoachSDK",
            dependencies: [
                .target(name: "PrivateSDK"),
                .product(name: "Lottie-Dynamic", package: "lottie-ios"),
                .product(name: "SnapKit-Dynamic", package: "SnapKit"),
            ],
            path: "Sources/ZingCoachSDK"
        ),
    ]
)
