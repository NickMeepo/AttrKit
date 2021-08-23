//
//  AttrNumber.swift
//  AttrKit
//
//  Created by HanGang on 2020/7/9.
//  Copyright © 2020 NickMeepo. All rights reserved.
//

import Foundation
import CoreGraphics

/** General numeric value types supported in AttrKit.
 
We get CGFloat and NSNumber from these types.
 
**Supported Types**:
    - **Int**
    - **Float**
    - **Double**
    - **CGFloat**
 */
public protocol AttrNumber { }

extension Int: AttrNumber { }

extension Float: AttrNumber { }

extension Double: AttrNumber { }

extension CGFloat: AttrNumber { }

extension AttrNumber {

    internal var attributeFloat: CGFloat {
        switch self {
        case let value as Int:
            return CGFloat(value)
        case let value as Float:
            return CGFloat(value)
        case let value as Double:
            return CGFloat(value)
        case let value as CGFloat:
            return value
        default:
            return 0
        }
    }

    internal var rawNumber: NSNumber {
        switch self {
        case let value as Int:
            return NSNumber(value: value)
        case let value as Float:
            return NSNumber(value: value)
        case let value as Double:
            return NSNumber(value: value)
        case let value as CGFloat:
            return NSNumber(value: Double(value))
        default:
            return 0
        }
    }

    internal var nonNegative: CGFloat {
        let value = self.attributeFloat
        return value >= 0 ? value : 0
    }

}
