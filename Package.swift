// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "swift-parse-examples",
    products: [
      .executable(name: "brainfuck", targets: ["Brainfuck"]),
    ],
    dependencies: [
      .package(url: "https://github.com/mgadda/swift-parse", .branch("0.4.0"))
      // Uncomment for development
//      .package(url: "../swift-parse", .branch("master"))
    ],
    targets: [
      .target(
        name: "Brainfuck",
        dependencies: ["SwiftParse"]
      )
    ]
)
