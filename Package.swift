// swift-tools-version: 6.4

import PackageDescription

let package = Package(
    name: "swift-renderer-document",
    platforms: [
        .macOS(.v27),
        .iOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
        .visionOS(.v27),
    ],
    products: [
        .library(name: "Renderer Document", targets: ["Renderer Document"]),
        .library(name: "Renderer Document Test Support", targets: ["Renderer Document Test Support"]),
    ],
    dependencies: [
        .package(url: "https://github.com/swift-atoms/swift-renderer.git", branch: "main"),
        .package(url: "https://github.com/swift-atoms/swift-byte.git", branch: "main"),
    ],
    targets: [
        .target(
            name: "Renderer Document",
            dependencies: [
                .product(name: "Renderer", package: "swift-renderer"),
                .product(name: "Byte", package: "swift-byte"),
            ]
        ),
        .target(
            name: "Renderer Document Test Support",
            dependencies: [
                .target(name: "Renderer Document"),
                .product(name: "Byte", package: "swift-byte"),
            ],
            path: "Tests/Support"
        ),
        .testTarget(
            name: "Renderer Document Tests",
            dependencies: [
                .target(name: "Renderer Document"),
                .target(name: "Renderer Document Test Support"),
                .product(name: "Byte", package: "swift-byte"),
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin].contains(target.type) {
    target.swiftSettings =
        (target.swiftSettings ?? []) + [
            .strictMemorySafety(),
            .enableUpcomingFeature("ExistentialAny"),
            .enableUpcomingFeature("InternalImportsByDefault"),
            .enableUpcomingFeature("MemberImportVisibility"),
            .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
            .enableUpcomingFeature("InferIsolatedConformances"),
            .enableExperimentalFeature("Lifetimes"),
            .treatAllWarnings(as: .error),
        ]
}
