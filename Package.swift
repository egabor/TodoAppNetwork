// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "todoapp-network",
    platforms: [.macOS(.v10_15),
                .iOS(.v14),
                .tvOS(.v10),
                .watchOS(.v3)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "todoapp-network",
            targets: ["todoapp-network"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/Alamofire/Alamofire", .exact("5.5.0")),
        .package(url: "https://github.com/Swinject/Swinject", .exact("2.8.1")),
        .package(url: "https://github.com/apple/swift-log.git", .exact("1.4.2"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "todoapp-network",
            dependencies: [
                "Alamofire",
                "Swinject",
                .product(name: "Logging", package: "swift-log")
            ]),
        .testTarget(
            name: "todoapp-networkTests",
            dependencies: [
                "todoapp-network",
                .product(name: "Logging", package: "swift-log")
            ])
    ]
)
