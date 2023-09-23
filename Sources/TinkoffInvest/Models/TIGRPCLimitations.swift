//
//  Created by Roman Nabiullin
//

import Foundation
import TinkoffInvestSDK

// MARK: - Model

public struct TIGRPCLimitations: Equatable, Sendable {

	// MARK: Exposed properties

	public let unaryRequestLimits: [UnaryRequestLimit]

	// MARK: Init

	internal init(_ response: GetUserTariffResponse) {
		self.unaryRequestLimits = response.unaryLimits.map({ limit in
			return UnaryRequestLimit(
				maxRequestsPerMinute: UInt(limit.limitPerMinute),
				grpcMethodNames: limit.methods
			)
		})
	}

}

// MARK: - Model

extension TIGRPCLimitations {

	public struct UnaryRequestLimit: Equatable, Sendable {

		// MARK: Exposed properties

		public let maxRequestsPerMinute: UInt

		public let grpcMethodNames: [String]

		// MARK: Init

		public init(maxRequestsPerMinute: UInt, grpcMethodNames: [String]) {
			self.maxRequestsPerMinute = maxRequestsPerMinute
			self.grpcMethodNames = grpcMethodNames
		}

	}

}
