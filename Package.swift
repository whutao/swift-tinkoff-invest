// swift-tools-version: 5.8
import PackageDescription

let package = Package(
	name: "swift-tinkoff-invest",
	platforms: [.iOS(.v15), .macOS(.v11)],
	products: [
		.library(name: "TinkoffInvest", targets: ["TinkoffInvest"])
	],
	dependencies: [
		.package(
			url: "https://github.com/pointfreeco/swift-identified-collections.git",
			from: Version(1, 0, 0)
		),
		.package(
			url: "https://github.com/whutao/TinkoffInvestSwiftSDK.git",
			branch: "main"
		),
		.package(
			url: "https://github.com/vyshane/grpc-swift-combine.git",
			from: Version(1, 1, 0)
		),
		.package(
			url: "https://github.com/apple/swift-protobuf.git",
			from: Version(1, 23, 0)
		)
	],
	targets: [
		.target(name: "_Extensions"),
		.target(name: "TinkoffInvest", dependencies: [
			.product(name: "CombineGRPC", package: "grpc-swift-combine"),
			.target(name: "_Extensions"),
			.product(name: "IdentifiedCollections", package: "swift-identified-collections"),
			.product(name: "SwiftProtobuf", package: "swift-protobuf"),
			.product(name: "TinkoffInvestSDK", package: "TinkoffInvestSwiftSDK")
		])
	]
)
