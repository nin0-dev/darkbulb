// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Darkbulb",
  dependencies: [
    .package(url: "https://github.com/llsc12/DDBKit", from: "0.1.1"),
    .package(url: "https://github.com/swiftpackages/DotEnv.git", from: "3.0.0"),
  ],
  targets: [
    .executableTarget(
      name: "Darkbulb",
      dependencies: [
        "DDBKit",
        .product(name: "DotEnv", package: "DotEnv"),
        .product(name: "DDBKitUtilities", package: "DDBKit"),
        .product(name: "DDBKitFoundation", package: "DDBKit"),
      ]
    ),
  ]
)
