//
//  AttrRangable.swift
//  AttrKit
//
//  Created by HanGang on 2020/7/9.
//

import Foundation

public class AttrRangable: AttrExtendable {

    internal func withRange(_ range: AttrRange) -> AttrExtendable {
        let result = AttrExtendable(raw: self.raw, attributeItems: self.attributeItems)
        if let lastFromHere = result.attributeItems.lastIndex(where: { $0.key == .fromHere }) {
            for index in stride(from: lastFromHere + 1, to: result.attributeItems.count, by: 1) {
                let item = result.attributeItems[index]
                result.attributeItems[index] = AttrItem(item.key, value: item.value, range: range)
            }
            result.attributeItems.remove(at: lastFromHere)
        } else if let item = result.attributeItems.popLast() {
            result.attributeItems.append(AttrItem(item.key, value: item.value, range: range))
        }
        return result
    }

}

public extension AttrRangable {

    func inRange(from start: Int, length: Int) -> AttrExtendable {
        self.withRange(.range(location: start, length: length))
    }

    func inRange(length: Int, to end: Int) -> AttrExtendable {
        self.withRange(.reverse(location: end, length: length))
    }

    func inRange(from start: Int, to end: Int) -> AttrExtendable {
        self.withRange(.range(location: start, length: end - start))
    }

    func inMatch(_ pattern: String) -> AttrExtendable {
        self.withRange(.match(pattern: pattern))
    }

    func inFirstMatch(_ pattern: String) -> AttrExtendable {
        self.withRange(.firstMatch(pattern: pattern))
    }

    func inOccur(_ subString: String) -> AttrExtendable {
        self.withRange(.occur(subString: subString))
    }

    func inFirstOccur(_ subString: String) -> AttrExtendable {
        self.withRange(.firstOccur(subString: subString))
    }

}
