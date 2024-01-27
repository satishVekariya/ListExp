// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Modules",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "Utils",
            targets: ["Utils"]
        ),
        .library(
            name: "ExpandableList",
            targets: ["ExpandableList", "ExpandableListUI"]
        ),
    ],
    targets: [
        .target(
            name: "Utils"
        ),
        .target(
            name: "ExpandableList"
        ),
        .target(
            name: "ExpandableListUI",
            dependencies: [
                "ExpandableList",
                "Utils"
            ]
        ),
    ]
)
