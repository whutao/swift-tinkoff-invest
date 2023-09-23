//
//  Created by Roman Nabiullin
//

import Foundation

// MARK: - Sequence+sorted

extension Sequence {

	/// Returns the elements of the sequence, sorted in the increasing order using the given keypath.
	@inlinable
	public func sorted<Value: Comparable>(
		by keyPath: KeyPath<Self.Element, Value>
	) -> [Self.Element] {
		return self.sorted(by: keyPath, using: <)
	}

	/// Returns the elements of the sequence, sorted in the increasing order using the given keypath.
	@inlinable
	public func sorted<Value: Comparable>(
		by keyPath: KeyPath<Self.Element, Value?>
	) -> [Self.Element] {
		return self.sorted(by: keyPath, using: { valueA, valueB in
			guard let valueA else { return true }
			guard let valueB else { return false }
			return valueA < valueB
		})
	}

	/// Returns the elements of the sequence, sorted in the increasing order using the given keypath.
	@inlinable
	public func sorted<Value: Comparable>(
		by keyPath1: KeyPath<Self.Element, Value>,
		and keyPath2: KeyPath<Self.Element, Value>
	) -> [Self.Element] {
		return self.sorted(by: keyPath1, and: keyPath2, using: <)
	}

	/// Returns the elements of the sequence, sorted using the given predicate as the comparison between elements and the keypath.
	@inlinable
	public func sorted<Value>(
		by keyPath: KeyPath<Self.Element, Value>,
		using valuesAreInIncreasingOrder: (Value, Value) throws -> Bool
	) rethrows -> [Self.Element] {
		return try self.sorted {
			try valuesAreInIncreasingOrder($0[keyPath: keyPath], $1[keyPath: keyPath])
		}
	}

	/// Returns the elements of the sequence, sorted using the given predicate as the comparison between elements, the keypath and the suplementary keypath.
	@inlinable
	public func sorted<Value: Comparable>(
		by keyPath1: KeyPath<Self.Element, Value>,
		and keyPath2: KeyPath<Self.Element, Value>,
		using valuesAreInIncreasingOrder: (Value, Value) throws -> Bool
	) rethrows -> [Self.Element] {
		return try self.sorted {
			if $0[keyPath: keyPath1] == $1[keyPath: keyPath1] {
				return try valuesAreInIncreasingOrder($0[keyPath: keyPath2], $1[keyPath: keyPath2])
			} else {
				return try valuesAreInIncreasingOrder($0[keyPath: keyPath1], $1[keyPath: keyPath1])
			}
		}
	}

}
