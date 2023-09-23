//
//  Created by Roman Nabiullin
//

extension Optional {

	/// Instead of bare `??` operator.
	///
	/// A convenient way to write:
	/// ```
	/// let optionalString: String? = nil
	///
	/// print(optionalString.unwrapped(or: "Default string"))
	/// ```
	/// instead of:
	/// ```
	/// let optionalString: String? = nil
	///
	/// print(optionalString ?? "Default string")
	/// ```
	@inlinable
	@inline(__always)
	public func unwrapped(or defaultValue: Wrapped) -> Wrapped {
		if let wrapped = self {
			return wrapped
		} else {
			return defaultValue
		}
	}

	/// Instead of the bare`!` force unwrap operator.
	///
	/// A convenient way to write:
	/// ```
	/// let optionalString: String? = "String"
	///
	/// print(optionalString.forceUnwrapped(because: "Always not nil."))
	/// ```
	/// instead of:
	/// ```
	/// let optionalString: String? = "String"
	///
	/// // Always not nil.
	/// print(optionalString!)
	/// ```
	@inlinable
	@inline(__always)
	public func forceUnwrapped(because assumption: String) -> Wrapped {
		if let wrapped = self {
			return wrapped
		} else {
			fatalError("Unexpectedly found nil. Failed assumption: \(assumption).")
		}
	}

	/// Returns a wrapped value if an optional can be unwrapped. Otherwise, throw an `error`.
	@inlinable
	@inline(__always)
	public func unwrapped(or error: Error) throws -> Wrapped {
		if let wrapped = self {
			return wrapped
		} else {
			throw error
		}
	}

}
