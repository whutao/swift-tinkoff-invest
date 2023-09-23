//
//  Created by Roman Nabiullin
//

/// Instead of bare `!`  operator.
///
/// A convenient way to write:
/// ```
/// if not(isEnabled), not(someInterger == 2) {
///     ...
/// }
/// ```
/// instead of
/// ```
/// if !isEnabled, someInterger != 2 {
///     ...
/// }
/// ```
@inlinable
@inline(__always)
public var not: (Bool) -> Bool {
	return (!)
}
