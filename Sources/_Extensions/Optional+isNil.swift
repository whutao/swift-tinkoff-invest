//
//  Created by Roman Nabiullin
//

extension Optional {

	/// Returns `false` if an optional contains a value, `true` otherwise.
	///
	/// A convenient way to write, for example:
	/// ```
	/// let optionalString: String? = nil
	///
	/// print(optionalString.isNil)
	/// ```
	/// instead of:
	/// ```
	/// let optionalString: String? = nil
	///
	/// print(optionalString == nil)
	/// ```
	@inlinable
	@inline(__always)
	public var isNil: Bool {
		return self == nil
	}

	/// Returns `true` if an optional contains a value, `false` otherwise.
	///
	/// A convenient way to write, for example:
	/// ```
	/// let optionalString: String? = nil
	///
	/// print(optionalString.isNotNil)
	/// ```
	/// instead of:
	/// ```
	/// let optionalString: String? = nil
	///
	/// print(optionalString != nil)
	/// ```
	@inlinable
	@inline(__always)
	public var isNotNil: Bool {
		return self != nil
	}

}
