import SwiftUI

public extension ActivityRing {
	struct Style {
		let lineWidth: CGFloat
		let tailColor: SwiftUI.Color
		let headColor: SwiftUI.Color
		let backgroundColor: SwiftUI.Color
		
		public init(
			lineWidth: CGFloat,
			tailColor: SwiftUI.Color,
			headColor: SwiftUI.Color,
			backgroundColor: SwiftUI.Color
		) {
			self.lineWidth = lineWidth
			self.tailColor = tailColor
			self.headColor = headColor
			self.backgroundColor = backgroundColor
		}
	}
}
