//
//  Created by Roman Nabiullin
//

import Foundation
import TinkoffInvestSDK

// MARK: - Model

public struct TIBondCoupon: Equatable, Sendable, Identifiable {

	// MARK: Exposed properties

	public var id: String {
		return figi + order.description
	}

	public let figi: TIFIGI

	public let order: UInt

	public let date: Date

	public let amount: TIAmount

	public let startDate: Date

	public let endDate: Date

	public let periodInDays: UInt

	public let kind: Kind

	// MARK: Init

	public init(
		figi: TIFIGI,
		order: UInt,
		date: Date,
		amount: TIAmount,
		startDate: Date,
		endDate: Date,
		periodInDays: UInt,
		kind: Kind
	) {
		self.figi = figi
		self.order = order
		self.date = date
		self.amount = amount
		self.startDate = startDate
		self.endDate = endDate
		self.periodInDays = periodInDays
		self.kind = kind
	}

	internal init?(_ response: Coupon) {
		guard let date = Date(response.couponDate) else {
			return nil
		}
		guard let startDate = Date(response.couponStartDate) else {
			return nil
		}
		guard let endDate = Date(response.couponEndDate) else {
			return nil
		}
		self.init(
			figi: response.figi,
			order: UInt(response.couponNumber),
			date: date,
			amount: .init(response.payOneBond.asMoneyAmount.value),
			startDate: startDate,
			endDate: endDate,
			periodInDays: UInt(response.couponPeriod),
			kind: .init(response.couponType)
		)
	}

}

// MARK: - TIBondCoupon+Kind

extension TIBondCoupon {

	public enum Kind: UInt, Equatable, Sendable {

		// MARK: Case

		case constant = 0

		case floating = 1

		case other = 100

		// MARK: Exposed properties

		internal init(_ response: CouponType) {
			switch response {
			case .constant:
				self = .constant
			case .floating:
				self = .floating
			default:
				self = .other
			}
		}

	}

}
