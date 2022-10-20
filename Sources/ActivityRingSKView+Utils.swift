//The MIT License (MIT)
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


import UIKit
import SpriteKit

#if canImport(UIKit)
public typealias NSUIColor = UIColor
public typealias BezierPath = UIBezierPath
#else
#if canImport(AppKit)
public typealias NSUIColor = NSColor
public typealias BezierPath = NSBezierPath
#endif
#endif

/// A protocol that describes types which can be animated / interpolated
protocol Animatable {

    /// Interpolates two values using a given ratio
    ///
    /// The ratio represented the proportion of the second value (i.e. `to`).
    /// So a ratio of `0` would return the starting `from` value, a ratio of `1`
    /// would return the final `to` value, and so on.
    ///
    /// - Parameters:
    ///   - firstValue: The starting value for the interpolation. This is the
    ///     value returned when the `ratio` is 0
    ///   - secondValue: The ending value for the interpolation. This is the
    ///     value returned when the `ratio` is 1
    ///   - ratio: The proportion of the interpolation
    /// - Returns: The interpolated value
    static func interpolate(from firstValue: Self, to secondValue: Self, withRatio ratio: Double) -> Self
}

struct Animator<T: Animatable> {

    // MARK:- Private variables

    private let initialValue: T
    private let targetValue: T
    private let startTime: TimeInterval
    private let duration: TimeInterval

    // MARK:- Initializers

    init(from initialValue: T, to targetValue: T, startTime: TimeInterval, duration: TimeInterval) {
        self.initialValue = initialValue
        self.targetValue  = targetValue
        self.startTime    = startTime
        self.duration     = duration
    }

    // MARK:- Public methods

    func isAnimating(at time: TimeInterval) -> Bool {
        return time <= startTime + duration
    }

    func value(at time: TimeInterval) -> T {
        guard isAnimating(at: time) else {
            return targetValue
        }

        let ratio = max(0, min(1, (time - startTime) / duration))
        let easedRatio = quadraticallyEasing(ratio)
        return T.interpolate(from: initialValue, to: targetValue, withRatio: easedRatio)
    }

    // MARK:- Private methods

    private func quadraticallyEasing(_ value: Double) -> Double {
        if value < 0.5 {
            return 2 * value * value;
        } else {
            return (-2 * value * value) + (4 * value) - 1;
        }
    }

}


extension Double: Animatable {
    static func interpolate(from firstValue: Double, to secondValue: Double, withRatio ratio: Double) -> Double {
        firstValue + (secondValue - firstValue) * ratio
    }
}

extension NSUIColor {
    /// Returns the red, green, blue, and alpha components
    ///
    /// Returns nil if the conversion to the RGBA NSUIColorspace wasn't successful
    var rgba: (CGFloat, CGFloat, CGFloat, CGFloat)? {
        var values: (CGFloat, CGFloat, CGFloat, CGFloat) = (0, 0, 0, 0)
        let isConversionSuccessful = getRed(&values.0, green: &values.1, blue: &values.2, alpha: &values.3)

        guard isConversionSuccessful else {
            return nil
        }

        return values
    }
}
