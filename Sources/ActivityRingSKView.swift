// The MIT License (MIT)
//
// Copyright (c) 2017 Harshil Shah <harshilshah1910@me.com>
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.


import SpriteKit

public final class ActivityRingView: SKView {

    // MARK:- Public variables

    /// The progress, calculated in terms of number of revolutions of the
    /// ring. A value of 1 corresponds to one full revolution
    ///
    /// Setting this value updates the ring immediately. To animate the change,
    /// see the `animateProgress` method
    ///
    /// The default value is `0.0`
    public var progress: Double {
        get { return activityRingScene.progress }
        set { activityRingScene.progress = newValue }
    }

    /// The width of the activity ring
    ///
    /// The default value is `60.0`
    public var ringWidth: CGFloat {
        get { return activityRingScene.ringWidth }
        set { activityRingScene.ringWidth = newValue }
    }

    /// The NSUIColor at the start of the ring. The alpha value is ignored while
    /// rendering
    ///
    /// The default value is `.purple`
    public var startColor: NSUIColor {
        get { return activityRingScene.startColor }
        set { activityRingScene.startColor = newValue }
    }

    /// The NSUIColor at the end of the ring. The alpha value is ignored while
    /// rendering
    ///
    /// The default value is `.blue`
    public var endColor: NSUIColor {
        get { return activityRingScene.endColor }
        set { activityRingScene.endColor = newValue }
    }

    /// The NSUIColor of the background ring.
    ///
    /// If a particular value isn't specified (i.e. if the value is `nil`), the
    /// background ring's NSUIColor is the `startColor` with an opacity of `0.25`
    ///
    /// The default value is `nil`
    public var backgroundRingColor: NSUIColor? {
        get { return activityRingScene.backgroundRingColor }
        set { activityRingScene.backgroundRingColor = newValue }
    }

    // MARK:- Private variables

    private lazy var activityRingScene = ActivityRingScene()

    // MARK:- Initializers

    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    override public func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    private func setup() {
        allowsTransparency = true
        activityRingScene.scaleMode = .aspectFit
        presentScene(activityRingScene)
    }

    // MARK:- Public methods

    /// Animates the ring's progress from its current value to a given value,
    /// with a specified animation duration
    ///
    /// The progress is calculated in terms of number of revolutions of the
    /// ring. A value of 1 corresponds to one full revolution
    ///
    /// - Parameters:
    ///   - targetValue: The desired `progress` for the ring`. This is required
    ///     to be a non-negative (0 or more) value
    ///   - duration: The duration of the progress animation, measured in
    ///     seconds. This is required to be a non-negative (0 or more) value
    public func animateProgress(to targetValue: Double, withDuration duration: TimeInterval) {
        activityRingScene.animateProgress(to: targetValue, withDuration: duration)
    }

}
