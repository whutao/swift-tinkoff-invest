//
//  Created by Roman Nabiullin
//

import Foundation
import TinkoffInvestSDK

// MARK: - Model

public typealias TIAmount = Double

// MARK: - TIAmount+init

extension TIAmount {

	internal init(_ response: Quotation) {
		self.init(response.asAmount)
	}

	internal init(_ decimal: Decimal) {
		self.init(NSDecimalNumber(decimal: decimal).doubleValue)
	}

}
