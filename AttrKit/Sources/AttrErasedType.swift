//
//  AttrErasedType.swift
//  AttrKit
//
//  Created by HanGang on 2020/7/10.
//  Copyright © 2020 NickMeepo. All rights reserved.
//

import Foundation

/** A OptionSet consisting of attributes keys which designated to erase specified attributes from attributed string.

**Erased Types**:

    - **font**
    - **underline**
    - **strikethrough**
    - **foreground**
    - **background**
    - **stroke**
    - **paragraph**
    - **ligature**
    - **kern**
    - **expansion**
    - **shadow**
    - **textEffect**
    - **obliqueness**
    - **baseline**
    - **link**
    - **attachment**
    - **writingDirection**
    - **glyphForm**
    - **all**: All attributes above will be erased.
    - **none**: None attributes will be erased.
 
*/
public struct AttrErasedType: OptionSet {

    public typealias RawValue = UInt

    public private(set) var rawValue: UInt

    public init(rawValue: AttrErasedType.RawValue) {
        self.rawValue = rawValue
    }

    public init(_ rawValue: UInt) {
        self.init(rawValue: rawValue)
    }

    public static let none              = AttrErasedType(UInt(0))
    public static let font              = AttrErasedType(UInt(1) << 0)
    public static let underline         = AttrErasedType(UInt(1) << 1)
    public static let strikethrough     = AttrErasedType(UInt(1) << 2)
    public static let foreground        = AttrErasedType(UInt(1) << 3)
    public static let background        = AttrErasedType(UInt(1) << 4)
    public static let stroke            = AttrErasedType(UInt(1) << 5)
    public static let paragraph         = AttrErasedType(UInt(1) << 6)
    public static let ligature          = AttrErasedType(UInt(1) << 7)
    public static let kern              = AttrErasedType(UInt(1) << 8)
    public static let expansion         = AttrErasedType(UInt(1) << 9)
    public static let shadow            = AttrErasedType(UInt(1) << 10)
    public static let textEffect        = AttrErasedType(UInt(1) << 11)
    public static let obliqueness       = AttrErasedType(UInt(1) << 12)
    public static let baseline          = AttrErasedType(UInt(1) << 13)
    public static let link              = AttrErasedType(UInt(1) << 14)
    public static let attachment        = AttrErasedType(UInt(1) << 15)
    public static let writingDirection  = AttrErasedType(UInt(1) << 16)
    public static let glyphForm         = AttrErasedType(UInt(1) << 17)
    public static let all               = AttrErasedType(UInt(1) << 18 - 1)

}
