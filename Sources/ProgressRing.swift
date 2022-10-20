import SwiftUI
import SpriteKit

@available(iOS 14, macOS 11, watchOS 7, *)
public struct ProgressRing: View {
	
	@State       private var viewSize:        CGRect                  = .zero
	@StateObject private var ringCoordinator: ActivityRingCoordinator = .init()
	
	private let style:    Style
	private var progress: Binding<CGFloat>
	
	public init(
		progress: Binding<CGFloat>,
		style:    Style
	) {
		self.style    = style
		self.progress = progress
	}
	
	public var body: some View {
		SpriteView(scene: ringCoordinator.scene)
			.storingSize(in: $viewSize)
			.onAppear {
				ringCoordinator.setProgress(progress.wrappedValue)
			}
			.onAppear {
				ringCoordinator.setWidth(style.lineWidth)
			}
			.onAppear {
				ringCoordinator.applyStyle(style)
			}
			.onChange(of: progress.wrappedValue) {
				ringCoordinator.setProgress($0)
			}
			.onChange(of: viewSize) {
				ringCoordinator.setSize($0.size)
			}
	}
}
