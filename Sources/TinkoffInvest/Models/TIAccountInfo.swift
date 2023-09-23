//
//  Created by Roman Nabiullin
//

import Foundation
import TinkoffInvestSDK

// MARK: - Model

public struct TIAccountInfo: Equatable, Identifiable, Sendable {

	// MARK: Exposed properties

	public let id: TIAccountID

	public let name: String

	public let openDate: Date

	public let kind: TIAccountKind

	// MARK: Init

	public init(
		id: TIAccountID,
		name: String,
		openDate: Date,
		kind: TIAccountKind
	) {
		self.id = id
		self.name = name
		self.openDate = openDate
		self.kind = kind
	}

	internal init?(_ response: Account) {
		guard let openDate = Date(response.openedDate) else {
			return nil
		}
		guard let kind = TIAccountKind(response.type) else {
			return nil
		}
		self.init(
			id: response.id,
			name: response.name,
			openDate: openDate,
			kind: kind
		)
	}

}
