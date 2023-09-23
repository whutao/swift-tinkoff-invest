//
//  Created by Roman Nabiullin
//

// swiftlint:disable static_operator

import Foundation

// MARK: Operators

/// Allows to produce expressions of kind `...filter(!\.isEnabled)...`.
@inlinable public prefix func ! <Root>(
	keyPath: KeyPath<Root, Bool>
) -> (Root) -> Bool {
	return { !$0[keyPath: keyPath] }
}

/// Allows to produce expressions of kind `...filter(\.isEnabled == true)...`.
@inlinable public func == <Root, Property: Equatable>(
	lhs: KeyPath<Root, Property>,
	rhs: Property
) -> (Root) -> Bool {
	return { $0[keyPath: lhs] == rhs }
}

/// Allows to produce expressions of kind `...filter(\.object === otherObject)...`.
@inlinable public func === <Root, Property: AnyObject>(
	lhs: KeyPath<Root, Property>,
	rhs: Property
) -> (Root) -> Bool {
	return { $0[keyPath: lhs] === rhs }
}

/// Allows to produce expressions of kind `...filter(\.isEnabled != true)...`.
@inlinable public func != <Root, Property: Equatable>(
	lhs: KeyPath<Root, Property>,
	rhs: Property
) -> (Root) -> Bool {
	return { $0[keyPath: lhs] != rhs }
}

/// Allows to produce expressions of kind `...filter(\.object !== otherObject)...`.
@inlinable public func !== <Root, Property: AnyObject>(
	lhs: KeyPath<Root, Property>,
	rhs: Property
) -> (Root) -> Bool {
	return { $0[keyPath: lhs] !== rhs }
}

/// Allows to produce expressions of kind `...filter(\.count < 4)...`.
@inlinable public func < <Root, Property: Comparable>(
	lhs: KeyPath<Root, Property>,
	rhs: Property
) -> (Root) -> Bool {
	return { $0[keyPath: lhs] < rhs }
}

/// Allows to produce expressions of kind `...filter(\.count <= 4)...`.
@inlinable public func <= <Root, Property: Comparable>(
	lhs: KeyPath<Root, Property>,
	rhs: Property
) -> (Root) -> Bool {
	return { $0[keyPath: lhs] <= rhs }
}

/// Allows to produce expressions of kind `...filter(\.count > 4)...`.
@inlinable public func > <Root, Property: Comparable>(
	lhs: KeyPath<Root, Property>,
	rhs: Property
) -> (Root) -> Bool {
	return { $0[keyPath: lhs] > rhs }
}

/// Allows to produce expressions of kind `...filter(\.count >= 4)...`.
@inlinable public func >= <Root, Property: Comparable>(
	lhs: KeyPath<Root, Property>,
	rhs: Property
) -> (Root) -> Bool {
	return { $0[keyPath: lhs] >= rhs }
}

// swiftlint:enable static_operator
