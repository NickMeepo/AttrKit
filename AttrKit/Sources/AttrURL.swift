//
//  AttrURL.swift
//  AttrKit
//
//  Created by HanGang on 2020/8/25.
//  Copyright © 2020 NickMeepo. All rights reserved.
//

import Foundation

/** General link value types supported in AttrKit.

We get URL from these types.

**Supported Types**:
    - **URL**
    - **NSURL**
    - **String**
    - **NSString**
*/
public protocol AttrURL { }

extension URL: AttrURL { }

extension NSURL: AttrURL { }

extension String: AttrURL { }

extension NSString: AttrURL { }

extension AttrURL {

    internal var attributeURL: URL? {
        switch self {
        case let url as URL:
            return url
        case let url as NSURL:
            return url as URL
        case let str as String:
            return URL(string: str)
        case let str as NSString:
            return URL(string: str as String)
        default:
            return nil
        }
    }

}
