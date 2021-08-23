//
//  AttrString.swift
//  AttrKit
//
//  Created by 韩钢 on 2021/6/30.
//  Copyright © 2021 NickMeepo. All rights reserved.
//

#if os(macOS)
public protocol AttrString { }

extension String: AttrString { }

extension NSString: AttrString { }

extension AttrString {

    internal var rawString: String {
        switch self {
        case let value as String:
            return value
        case let value as NSString:
            return String(value)
        default:
            return ""
        }
    }
    
}
#endif
