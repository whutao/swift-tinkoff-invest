//
//  Created by Roman Nabiullin
//

extension String {

	/// Returns `true` if an string contains a non-empty value, `false` otherwise.
	@inlinable
	@inline(__always)
	public var isNotEmpty: Bool {
		return !isEmpty
	}

}
