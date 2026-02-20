// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
import CompilerPluginSupport

let package = Package(
    name: "QuartzMore",
    platforms: [.iOS(.v18), .macOS(.v15)],
    products: [
        .library(
            name: "QuartzMore",
            targets: ["QuartzMore"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/mhdhejazi/Dynamic", from: "1.2.0"),
        .package(url: "https://github.com/nathantannar4/Turbocharger.git", from: "2.2.1"),
        .package(url: "https://github.com/quentinfasquel/CAFilterBuiltins.git", from: "0.1.0"),
        .package(url: "https://github.com/swiftlang/swift-syntax.git", from: "601.0.0-latest"),
    ],
    targets: [
        .target(
            name: "QuartzMore",
            dependencies: [
                "QuartzMoreCore",
                .product(name: "CAFilterBuiltins", package: "CAFilterBuiltins"),
                .product(name: "Turbocharger", package: "Turbocharger"),
            ],
        ),
        .target(
            name: "QuartzMoreCore",
            dependencies: [
                "QuartzMoreMacros",
                "QuartzMoreProxy",
                .product(name: "CAFilterBuiltins", package: "CAFilterBuiltins"),
                .product(name: "Dynamic", package: "Dynamic"),
            ],
        ),
        .target(
            name: "QuartzMoreProxy",
            publicHeadersPath: "."
        ),
        .target(
            name: "QuartzMoreMacros",
            dependencies: [
                "QuartzMoreMacrosImplementation"
            ]
        ),
        .macro(
            name: "QuartzMoreMacrosImplementation",
            dependencies: [
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax"),
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
            ]
        ),
        .testTarget(
            name: "QuartzMoreTests",
            dependencies: [
                "QuartzMore"
            ]
        ),
    ]
)

