//
//  Created by Roman Nabiullin
//

import CombineGRPC
import Foundation

// MARK: - Error

public struct TIError: Error, Equatable {

	// MARK: Exposed properties

	public let code: Int

	public let context: String

	// MARK: Init

	public init(code: Int, context: String) {
		self.code = code
		self.context = context
	}

	internal init(from rpcError: RPCError) {
		self.code = rpcError.status.code.rawValue
		self.context = rpcError.status.localizedDescription
	}

	// MARK: Exposed methods

	public static func emptyOrCorruptedResponse(context: String) -> TIError {
		return .init(code: -100, context: context)
	}

}
