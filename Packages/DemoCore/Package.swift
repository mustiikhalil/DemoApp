// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "DemoCore",
  platforms: [.iOS(.v14)],
  products: [
    // The idea here is to mimic having multiple swift packages since this is a tiny project
    .library(
      name: "DemoCore",
      targets: ["DemoCore"]),
    .library(
      name: "DemoNetworking",
      targets: ["DemoNetworking"]),
    .library(
      name: "DemoUI",
      targets: ["DemoUI"]),
    .library(
      name: "HomePageView",
      targets: ["HomePageView"]),
  ],
  dependencies: [
    .package(
      url: "https://github.com/pointfreeco/swift-snapshot-testing",
      exact: "1.10.0"
    ),
    .package(url: "https://github.com/onevcat/Kingfisher", exact: "7.6.1")
  ],
  targets: [
    .target(
      name: "HomePageView",
      dependencies: ["DemoCore", "DemoUI"]),
    .target(
      name: "DemoNetworking",
      dependencies: []),
    .target(
      name: "DemoUI",
      dependencies: [
        .product(name: "Kingfisher", package: "Kingfisher")
      ]),
    .target(
      name: "DemoCore",
      dependencies: []),
    .testTarget(
      name: "DemoCoreTests",
      dependencies: ["DemoCore"]),
    .testTarget(
      name: "DemoUIPackageTests",
      dependencies: [
        .product(name: "SnapshotTesting", package: "swift-snapshot-testing"),
        "DemoUI"
      ]),
    .testTarget(
      name: "DemoNetworkingTests",
      dependencies: ["DemoNetworking"]),
    .testTarget(
      name: "HomePageTests",
      dependencies: ["HomePageView"]),
  ]
)
