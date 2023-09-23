//
//  Created by Roman Nabiullin
//

import Foundation
import TinkoffInvestSDK

// MARK: - Model

public struct TIBond: Equatable, Sendable, Identifiable {

	// MARK: Exposed properties

	public var id: String {
		return figi
	}

	public let figi: TIFIGI

	public let ticker: TITicker

	public let name: String

	public let currency: TIMoneyCurrency

	public let initialNominal: TIAmount

	public let currentNominal: TIAmount

	public let minPriceIncrement: TIAmount

	public let accumulatedCouponIncome: TIAmount

	public let couponCountPerYear: UInt

	public let registrationDate: Date

	public let maturityDate: Date?

	public let issueSize: UInt

	public let exchange: TIExchange

	public let economySector: String

	public let countryOfRiskName: String

	public let countryOfRiskCode: String

	public let isCouponFloating: Bool

	public let isPerpetual: Bool

	public let isAmortizable: Bool

	// MARK: Init

	public init(
		figi: TIFIGI,
		ticker: TITicker,
		name: String,
		economySector: String,
		currency: TIMoneyCurrency,
		initialNominal: TIAmount,
		currentNominal: TIAmount,
		minPriceIncrement: TIAmount,
		accumulatedCouponIncome: TIAmount,
		couponCountPerYear: UInt,
		registrationDate: Date,
		maturityDate: Date?,
		issueSize: UInt,
		exchange: TIExchange,
		countryOfRiskName: String,
		countryOfRiskCode: String,
		isCouponFloating: Bool,
		isPerpetual: Bool,
		isAmortizable: Bool
	) {
		self.figi = figi
		self.ticker = ticker
		self.name = name
		self.economySector = economySector
		self.currency = currency
		self.initialNominal = initialNominal
		self.currentNominal = currentNominal
		self.minPriceIncrement = minPriceIncrement
		self.accumulatedCouponIncome = accumulatedCouponIncome
		self.couponCountPerYear = couponCountPerYear
		self.registrationDate = registrationDate
		self.maturityDate = maturityDate
		self.issueSize = issueSize
		self.exchange = exchange
		self.countryOfRiskName = countryOfRiskName
		self.countryOfRiskCode = countryOfRiskCode
		self.isCouponFloating = isCouponFloating
		self.isPerpetual = isPerpetual
		self.isAmortizable = isAmortizable
	}

	internal init?(response: BondResponse) {
		guard response.hasInstrument else {
			return nil
		}
		let instrument = response.instrument
		guard let currency = TIMoneyCurrency(isoCode: instrument.currency) else {
			return nil
		}
		guard let realExhange = TIExchange(instrument.realExchange) else {
			return nil
		}
		guard let registrationDate = Date(instrument.stateRegDate) else {
			return nil
		}
		self.init(
			figi: instrument.figi,
			ticker: instrument.ticker,
			name: instrument.name,
			economySector: instrument.sector,
			currency: currency,
			initialNominal: .init(instrument.initialNominal.asMoneyAmount.value),
			currentNominal: .init(instrument.nominal.asMoneyAmount.value),
			minPriceIncrement: .init(instrument.minPriceIncrement),
			accumulatedCouponIncome: .init(instrument.aciValue.asMoneyAmount.value),
			couponCountPerYear: UInt(instrument.couponQuantityPerYear),
			registrationDate: registrationDate,
			maturityDate: .init(instrument.maturityDate),
			issueSize: UInt(instrument.issueSize),
			exchange: realExhange,
			countryOfRiskName: instrument.countryOfRiskName,
			countryOfRiskCode: instrument.countryOfRisk,
			isCouponFloating: instrument.floatingCouponFlag,
			isPerpetual: instrument.perpetualFlag,
			isAmortizable: instrument.amortizationFlag
		)
	}

}
