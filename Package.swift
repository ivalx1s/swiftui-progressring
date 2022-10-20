// swift-tools-version: 5.7

import PackageDescription


/// A Swift Package of HarshilShah/ActivityRings, repacked to fluently work with SwiftUI
/// [original implementation source](https://github.com/HarshilShah/ActivityRings)
let package = Package(
    name: "swiftui-progressring",
	platforms: [
		.iOS(.v14),
		.watchOS(.v7),
		.macOS(.v11)
	],
    products: [
        .library(
            name: "ProgressRing",
            targets: ["ProgressRing"]
		),
    ],
    targets: [
        .target(
            name: "ProgressRing",
            dependencies: [],
			path: "Sources"
		)
    ]
)
