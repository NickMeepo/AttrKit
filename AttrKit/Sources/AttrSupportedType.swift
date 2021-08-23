//
//  AttrSupportedType.swift
//  AttrKit
//
//  Created by HanGang on 2020/7/9.
//

import Foundation

#if os(iOS) || os(tvOS)
import UIKit.NSTextAttachment
#endif

/** General Types supported in AttrKit to start the chain from .attr.

        aString.attr
        aNSString.attr
        aNSAttributedString.attr
        aNSTextAttachment.attr
 
**Supported Types**:
    - **String**
    - **NSString**
    - **NSAttributedString**
    - **NSTextAttachment**(unavailabel on watchOS)
    - **AttrHtml**
    - **AttrRtf**
    - **AttrRtfd**
 */
public protocol AttrSupportedType {

    var rawAttributedString: NSAttributedString { get }

}

extension AttrSupportedType {

    /// AttrKit: Start an attributed chain.
    public var attr: AttrExtendable {
        AttrExtendable(raw: self.rawAttributedString, attributeItems: [])
    }

}

extension String: AttrSupportedType {

    public var rawAttributedString: NSAttributedString {
        NSAttributedString(string: self)
    }

}

extension NSString: AttrSupportedType {

    public var rawAttributedString: NSAttributedString {
        NSAttributedString(string: String(self))
    }

}

extension NSAttributedString: AttrSupportedType {

    public var rawAttributedString: NSAttributedString {
        self
    }

}

extension AttrHtml: AttrSupportedType {

}

extension AttrRtf: AttrSupportedType {
    
}

extension AttrRtfd: AttrSupportedType {
    
}

#if os(iOS) || os(tvOS)
extension NSTextAttachment: AttrSupportedType {

    public var rawAttributedString: NSAttributedString {
        NSAttributedString(attachment: self)
    }

}
#endif
