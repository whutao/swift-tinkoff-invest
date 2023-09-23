//
//  Created by Roman Nabiullin
//

import Foundation
import TinkoffInvestSDK

// MARK: - Model

public struct TIUserInfo: Equatable, Sendable {

	// MARK: Exposed properties

	public let tariffName: String

	public let hasPremiumStatus: Bool

	public let hasQualifiedInvestorStatus: Bool

	// MARK: Init

	public init(
		tariffName: String,
		hasPremiumStatus: Bool,
		hasQualifiedInvestorStatus: Bool
	) {
		self.tariffName = tariffName
		self.hasPremiumStatus = hasPremiumStatus
		self.hasQualifiedInvestorStatus = hasQualifiedInvestorStatus
	}

	internal init(_ response: GetInfoResponse) {
		self.init(
			tariffName: response.tariff,
			hasPremiumStatus: response.premStatus,
			hasQualifiedInvestorStatus: response.qualStatus
		)
	}

}
