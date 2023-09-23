//
//  File.swift
//  
//
//  Created by Roman Nabiullin on 23.09.2023.
//

import Combine
import Foundation

// MARK: - Error

public enum AsyncError: Error {

	// MARK: Case

	case finishedWithoutValue

}

// MARK: - Publisher + async version

extension Publisher {

	/// Converts **one-shot** operation publisher into an async version.
	public func `async`() async throws -> Output {
		return try await withCheckedThrowingContinuation { continuation in
			var cancellable: AnyCancellable?
			var finishedWithoutValue = true
			cancellable = first().sink(
				receiveCompletion: { result in
					switch result {
					case .finished:
						if finishedWithoutValue {
							continuation.resume(throwing: AsyncError.finishedWithoutValue)
						}
					case let .failure(error):
						continuation.resume(throwing: error)
					}
					cancellable?.cancel()
				},
				receiveValue: { value in
					finishedWithoutValue = false
					continuation.resume(with: .success(value))
				}
			)
		}
	}

}
