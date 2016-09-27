import PackageDescription

let package = Package(
    name: "swift-parse-example",
    dependencies: [
      .Package(url: "file:///Users/mgadda/workspace/swift-parse", majorVersion: 0)
    ]
)
