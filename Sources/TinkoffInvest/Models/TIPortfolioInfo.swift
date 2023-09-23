//
//  Created by Roman Nabiullin
//

import Foundation
import IdentifiedCollections
import TinkoffInvestSDK

// MARK: - Model

public struct TIPortfolioInfo: Equatable, Sendable, Identifiable {

	// MARK: Exposed properties

	public var id: TIAccountID {
		return associatedAccountId
	}

	public let associatedAccountId: TIAccountID

	public let positions: IdentifiedArrayOf<Position>

	// MARK: Init

	public init(
		associatedAccountId: TIAccountID,
		positions: IdentifiedArrayOf<Position>
	) {
		self.associatedAccountId = associatedAccountId
		self.positions = positions
	}

	internal init(_ response: PortfolioResponse) {
		self.init(
			associatedAccountId: response.accountID,
			positions: .init(uniqueElements: response.positions.compactMap(Position.init))
		)
	}

}
