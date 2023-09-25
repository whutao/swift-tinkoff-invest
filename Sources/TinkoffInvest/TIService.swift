//
//  Created by Roman Nabiullin
//

import Combine
import CombineGRPC
import _Extensions
import Foundation
import IdentifiedCollections
import TinkoffInvestSDK

// MARK: - Service

public final class TIService {

	// MARK: Exposed properties

	public static let shared = TIService()

	// MARK: Private properties

	private lazy var tinkoffInvest = TinkoffInvestSDK(tokenProvider: self)

	private let queue = DispatchQueue(
		label: "swift-tinkoff-invest.service.tinkoffInvest",
		qos: .utility
	)

	private var token: String = .empty

	// MARK: Init

	private init() {

	}

	// MARK: Exposed methods

	public func setToken(_ newValue: String) {
		token = newValue
	}

}

// MARK: - TIService+TinkoffInvestTokenProvider

extension TIService: TinkoffInvestTokenProvider {

	public func provideToken() -> String {
		return token
	}

}

// MARK: - TIService+InvestAPI

extension TIService {

	// MARK: User service

	public func grpcLimitations() async throws -> TIGRPCLimitations {
		return try await tinkoffInvest.userService.getUserTariffRequest()
			.subscribe(on: queue)
			.map(TIGRPCLimitations.init)
			.mapError(TIError.init)
			.async()
	}

	public func userInfo() async throws -> TIUserInfo {
		return try await tinkoffInvest.userService.getUserInfo()
			.subscribe(on: queue)
			.map(TIUserInfo.init)
			.mapError(TIError.init)
			.async()
	}

	public func accounts(
		filterBy filterPredicate: ((TIAccountInfo) -> Bool)? = nil
	) async throws -> IdentifiedArrayOf<TIAccountInfo> {
		return try await tinkoffInvest.userService.getAccounts()
			.subscribe(on: queue)
			.map({ response in
				var tiAccounts = response.accounts.compactMap(TIAccountInfo.init)
				if let filterPredicate {
					tiAccounts = tiAccounts.filter(filterPredicate)
				}
				return IdentifiedArrayOf(uniqueElements: tiAccounts)
			})
			.mapError(TIError.init)
			.async()
	}

	// MARK: Instruments service

	private func bond(parameters: InstrumentParameters) async throws -> TIBond {
		return try await tinkoffInvest.instrumentsService.getBond(params: parameters)
			.subscribe(on: queue)
			.mapError(TIError.init)
			.tryMap({ response in
				guard let domainResponse = TIBond(response: response) else {
					throw TIError.emptyOrCorruptedResponse(
						context: "Cannot convert \(BondResponse.self) into \(TIBond.self)."
					)
				}
				return domainResponse
			})
			.async()
	}

	public func bond(figi: TIFIGI) async throws -> TIBond {
		return try await bond(parameters: .init(idType: .figi, id: figi))
	}

	public func bond(ticker: TITicker) async throws -> TIBond {
		return try await bond(parameters: .init(idType: .ticker, id: ticker))
	}
	
	public func bondCoupons(
		bondFigi: TIFIGI,
		dateRange: ClosedRange<Date>
	) async throws -> IdentifiedArrayOf<TIBondCoupon> {
		var request = GetBondCouponsRequest()
		request.figi = bondFigi
		request.from = .init(date: dateRange.lowerBound)
		request.to = .init(date: dateRange.upperBound)
		return try await tinkoffInvest.instrumentsService.getBondsCoupons(request: request)
			.subscribe(on: queue)
			.map({ response in
				let coupons = response.events.compactMap(TIBondCoupon.init)
				return IdentifiedArrayOf(uniqueElements: coupons)
			})
			.mapError(TIError.init)
			.async()
	}
	
	private func share(parameters: InstrumentParameters) async throws -> TIShare {
		return try await tinkoffInvest.instrumentsService.getShare(params: parameters)
			.subscribe(on: queue)
			.mapError(TIError.init)
			.tryMap({ response in
				guard let domainResponse = TIShare(response: response) else {
					throw TIError.emptyOrCorruptedResponse(
						context: "Cannot convert \(ShareResponse.self) into \(TIShare.self)."
					)
				}
				return domainResponse
			})
			.async()
	}
	
	public func share(figi: TIFIGI) async throws -> TIShare {
		return try await share(parameters: .init(idType: .figi, id: figi))
	}

	public func share(ticker: TITicker) async throws -> TIShare {
		return try await share(parameters: .init(idType: .ticker, id: ticker))
	}
	
	// MARK: Portfolio service

	public func portfolioInfo(accountId: TIAccountID) async throws -> TIPortfolioInfo {
		return try await tinkoffInvest.portfolioService.getPortfolio(accountID: accountId)
			.subscribe(on: queue)
			.map(TIPortfolioInfo.init)
			.mapError(TIError.init)
			.async()
	}

}
