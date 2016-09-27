import PackageDescription

let package = Package(
    name: "swift-parse-example",
    dependencies: [
      .Package(url: "https://github.com/mgadda/swift-parse", majorVersion: 0)
    ]
)
