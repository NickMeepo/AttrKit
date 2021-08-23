//
//  Extensions.swift
//  AttrKit
//
//  Created by HanGang on 2020/7/10.
//  Copyright © 2020 NickMeepo. All rights reserved.
//

import Foundation

extension RawRepresentable where RawValue == Int {

    internal var rawNumber: NSNumber {
        NSNumber(value: self.rawValue)
    }

}

extension Int {

    internal func clamp(from begin: Int, into end: Int) -> Int {
        if begin > end { return begin }
        return self < begin ? begin : (self > end ? end : self)
    }

}

extension NSAttributedString {

    internal func fetchAttributes<Value>(in nsrange: NSRange, key: NSAttributedString.Key) -> [(Value, NSRange)] {
        var result: [(Value, NSRange)] = []
        self.enumerateAttribute(key, in: nsrange, options: []) { value, range, _ in
            if let transformed = value as? Value {
                result.append((transformed, range))
            }
        }
        return result
    }

}

extension String {

    internal func nsIndexMapped(_ location: Int) -> Int? {
        guard let mapped = self.index(startIndex, offsetBy: location).samePosition(in: utf16) else { return nil }
        return utf16.distance(from: utf16.startIndex, to: mapped)
    }

    internal func nsRange(from range: Range<String.Index>) -> NSRange {
        guard let begin = range.lowerBound.samePosition(in: utf16),
            let end = range.upperBound.samePosition(in: utf16) else {
            return NSRange(location: 0, length: 0)
        }
        let location = utf16.distance(from: utf16.startIndex, to: begin)
        let length = utf16.distance(from: begin, to: end)
        return NSRange(location: location, length: length)
    }

}

extension AttrFont {

    internal func changeTraits(_ traits: AttrFontTraits) -> AttrFont {
        #if os(iOS) || os(watchOS) || os(tvOS)
        if let descriptor = self.fontDescriptor.withSymbolicTraits(traits) {
            return AttrFont(descriptor: descriptor, size: 0)
        } else {
            return self
        }
        #else
        let descriptor = self.fontDescriptor.withSymbolicTraits(traits)
        return AttrFont(descriptor: descriptor, size: 0) ?? self
        #endif
    }

    internal func changeSize(_ step: AttrFloat) -> AttrFont {
        let size = self.fontDescriptor.pointSize
        let descriptor = self.fontDescriptor.withSize(size + step)
        #if os(iOS) || os(watchOS) || os(tvOS)
        return AttrFont(descriptor: descriptor, size: 0)
        #else
        return AttrFont(descriptor: descriptor, size: 0) ?? self
        #endif
    }

}
