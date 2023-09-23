//
//  Created by Roman Nabiullin
//

import Foundation
import TinkoffInvestSDK

// MARK: - Model

public enum TIExchange: UInt8, Equatable, Sendable {

	// MARK: Case

	case moex = 0

	case rts = 1

	case otc = 2

	// MARK: Init

	internal init?(_ response: RealExchange) {
		switch response {
		case .moex:
			self = .moex
		case .rts:
			self = .rts
		case .otc:
			self = .otc
		case .unspecified, .UNRECOGNIZED:
			return nil
		}
	}

}
