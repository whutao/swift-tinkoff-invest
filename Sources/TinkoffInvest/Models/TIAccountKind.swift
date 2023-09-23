//
//  Created by Roman Nabiullin
//

import Foundation
import TinkoffInvestSDK

// MARK: - Model

public enum TIAccountKind: UInt8, Equatable, Sendable {

	// MARK: Case

	case brokerageAccount = 0

	case individualInvestmentAccount = 1

	case investBox = 2

	// MARK: Init

	internal init?(_ response: AccountType) {
		switch response {
		case .investBox:
			self = .investBox
		case .tinkoff:
			self = .brokerageAccount
		case .tinkoffIis:
			self = .individualInvestmentAccount
		default:
			return nil
		}
	}

}
