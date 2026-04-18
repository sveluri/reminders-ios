// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "Reminders",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "Reminders",
            targets: ["Reminders"]
        )
    ],
    targets: [
        .target(
            name: "Reminders",
            path: "Sources"
        )
    ]
)
