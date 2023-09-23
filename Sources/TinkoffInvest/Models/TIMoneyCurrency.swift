//
//  Created by Roman Nabiullin
//

import Foundation
import TinkoffInvestSDK

// MARK: - Model

public enum TIMoneyCurrency: UInt8, Equatable, Sendable {

	// MARK: Case

	case rub = 0

	case eur = 1

	case usd = 2

	// MARK: Exposed properties

	public var isoCode: String {
		switch self {
		case .rub:
			return "RUB"
		case .eur:
			return "EUR"
		case .usd:
			return "USD"
		}
	}

	// MARK: Init

	public init?(isoCode: String) {
		switch isoCode.uppercased() {
		case "RUB":
			self = .rub
		case "USD":
			self = .usd
		case "EUR":
			self = .eur
		default:
			return nil
		}
	}

}
