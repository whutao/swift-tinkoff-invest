//
//  Created by Roman Nabiullin
//

import Foundation
import TinkoffInvestSDK

// MARK: - Model

public struct TIShare: Equatable, Sendable, Identifiable {
	
	// MARK: Exposed properties
	
	public var id: String {
		return figi
	}
	
	public let figi: TIFIGI
	
	public let ticker: TITicker

	public let name: String

	public let kind: Kind

	public let lotSize: UInt
	
	public let currency: TIMoneyCurrency

	public let minPriceIncrement: TIAmount

	public let issueSize: UInt

	public let exchange: TIExchange

	public let countryOfRiskName: String

	public let countryOfRiskCode: String
	
	// MARK: Init
	
	public init(
		figi: TIFIGI,
		ticker: TITicker,
		name: String,
		kind: Kind,
		lotSize: UInt,
		currency: TIMoneyCurrency,
		minPriceIncrement: TIAmount,
		issueSize: UInt,
		exchange: TIExchange,
		countryOfRiskName: String,
		countryOfRiskCode: String
	) {
		self.figi = figi
		self.ticker = ticker
		self.name = name
		self.kind = kind
		self.lotSize = lotSize
		self.currency = currency
		self.minPriceIncrement = minPriceIncrement
		self.issueSize = issueSize
		self.exchange = exchange
		self.countryOfRiskName = countryOfRiskName
		self.countryOfRiskCode = countryOfRiskCode
	}
	
	internal init?(response: ShareResponse) {
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
		let kind: Kind = {
			switch instrument.shareType {
			case .common:
				return .common
			case .preferred:
				return .preferred
			default:
				return .other
			}
		}()
		self.init(
			figi: instrument.figi,
			ticker: instrument.ticker,
			name: instrument.name,
			kind: kind,
			lotSize: UInt(instrument.lot),
			currency: currency,
			minPriceIncrement: .init(instrument.minPriceIncrement.asAmount),
			issueSize: UInt(instrument.issueSize),
			exchange: realExhange,
			countryOfRiskName: instrument.countryOfRiskName,
			countryOfRiskCode: instrument.countryOfRisk
		)
	}
	
}

// MARK: - Kind

extension TIShare {
	
	public enum Kind: Equatable, Codable, Sendable {
		
		// MARK: Case
		
		case common
		
		case preferred
		
		case other
		
	}
	
}
