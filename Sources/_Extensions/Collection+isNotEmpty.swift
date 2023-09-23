//
//  Created by Roman Nabiullin
//

extension Collection {

	/// A Boolean value indicating whether the collection is not empty.
	@inlinable
	@inline(__always)
	public var isNotEmpty: Bool {
		return !isEmpty
	}

}
