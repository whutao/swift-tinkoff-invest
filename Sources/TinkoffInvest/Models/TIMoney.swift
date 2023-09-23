//
//  Created by Roman Nabiullin
//

import Foundation
import TinkoffInvestSDK

// MARK: - Model

public struct TIMoney: Equatable, Sendable {

	// MARK: Exposed properties

	public let currency: TIMoneyCurrency

	public let amount: TIAmount

	// MARK: Init

	public init(currency: TIMoneyCurrency, amount: TIAmount) {
		self.currency = currency
		self.amount = amount
	}

	internal init?(_ response: MoneyValue) {
		guard let currency = TIMoneyCurrency(isoCode: response.currency) else {
			return nil
		}
		self.init(
			currency: currency,
			amount: NSDecimalNumber(decimal: response.asMoneyAmount.value).doubleValue
		)
	}

}
