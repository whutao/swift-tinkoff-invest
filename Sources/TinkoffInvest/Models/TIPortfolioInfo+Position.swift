//
//  Created by Roman Nabiullin
//

import Foundation
import TinkoffInvestSDK

// MARK: - Model

extension TIPortfolioInfo {

	public struct Position: Equatable, Sendable, Identifiable {

		// MARK: Exposed properties

		public var id: String {
			return figi
		}

		public let figi: TIFIGI

		public let kind: Kind

		public let currency: TIMoneyCurrency

		public let currentPrice: TIAmount

		public let averagePrice: TIAmount

		public let count: UInt

		public let accumulatedCouponIncome: TIAmount?

		public let expectedYield: TIAmount

		public let isBlockedOnExchange: Bool

		// MARK: Init

		public init(
			figi: TIFIGI,
			kind: Kind,
			count: UInt,
			currency: TIMoneyCurrency,
			currentPrice: TIAmount,
			averagePrice: TIAmount,
			accumulatedCouponIncome: TIAmount?,
			expectedYield: TIAmount,
			isBlockedOnExchange: Bool
		) {
			self.figi = figi
			self.kind = kind
			self.currency = currency
			self.currentPrice = currentPrice
			self.averagePrice = averagePrice
			self.count = count
			self.accumulatedCouponIncome = accumulatedCouponIncome
			self.expectedYield = expectedYield
			self.isBlockedOnExchange = isBlockedOnExchange
		}

		internal init?(_ response: PortfolioPosition) {
			let kind: Kind? = {
				switch response.instrumentType {
				case "bond":
					return .bond
				case "share":
					return .share
				default:
					return nil
				}
			}()
			guard let kind else {
				return nil
			}
			guard let currency = TIMoneyCurrency(isoCode: response.currentPrice.currency) else {
				return nil
			}
			self.init(
				figi: response.figi,
				kind: kind,
				count: UInt(response.quantity.units),
				currency: currency,
				currentPrice: .init(response.currentPrice.asMoneyAmount.value),
				averagePrice: .init(response.averagePositionPrice.asMoneyAmount.value),
				accumulatedCouponIncome: .init(response.currentNkd.asMoneyAmount.value),
				expectedYield: .init(response.expectedYield),
				isBlockedOnExchange: response.blocked
			)
		}

	}

}

// MARK: - Kind

extension TIPortfolioInfo.Position {

	public enum Kind: UInt8, Equatable, Sendable {

		// MARK: Case

		case bond = 0

		case share = 1

	}

}
