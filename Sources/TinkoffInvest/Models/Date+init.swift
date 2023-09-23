//
//  Created by Roman Nabiullin
//

import Foundation
import SwiftProtobuf

// MARK: - Date+init

extension Date {

	internal init?(_ response: Google_Protobuf_Timestamp) {
		guard (response.seconds != .zero) || (response.nanos != .zero) else {
			return nil
		}
		self.init(timeIntervalSince1970: response.timeIntervalSince1970)
	}

}
