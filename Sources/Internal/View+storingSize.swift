import SwiftUI

internal extension View {
	
	/// Stores the view frame and origin in given coordinate space in provided storage.
	/// If condition is provided, storage will only be updated if condition evaluates to true.
	func storingSize(
		in storage: Binding<CGRect>,
		space: CoordinateSpace = .local,
		when condition: ((CGRect)->Bool)? = nil,
		logToConsole: Bool = false
	) -> some View {
		let color: (GeometryProxy) -> Color = { gr in
			DispatchQueue.main.async {
				let frame = gr.frame(in: space)
				guard storage.wrappedValue != frame else { return }
#if DEBUG
				if logToConsole {
					print("storing size for: \(frame)")
				}
#endif
				
				if let condition = condition {
					// condition is set, we need to evaluate it
					guard condition(frame) else {
						return
					}
					storage.wrappedValue = frame
					
				} else {
					storage.wrappedValue = frame
				}
			}
			return Color.clear
		}
		
		return self.background(
			GeometryReader { gr in color(gr) }
		)
	}
	
	/// Stores the view frame and origin in given coordinate space in provided storage.
	/// If condition is provided, storage will only be updated if condition evaluates to true.
	func storingSize(
		in storage: Binding<CGRect?>,
		space: CoordinateSpace = .local,
		when condition: ((CGRect)->Bool)? = nil,
		logToConsole: Bool = false
	) -> some View {
		let color: (GeometryProxy) -> Color = { gr in
			DispatchQueue.main.async {
				let frame = gr.frame(in: space)
				
#if DEBUG
				if logToConsole {
					print("storing size for: \(frame)")
				}
#endif
				
				guard storage.wrappedValue != frame else { return }
				if let condition = condition {
					// condition is set, we need to evaluate it
					guard condition(frame) else {
						return
					}
					storage.wrappedValue = frame
				} else {
					storage.wrappedValue = frame
				}
			}
			return Color.clear
		}
		
		return self.background(
			GeometryReader { gr in color(gr) }
		)
	}
}
