//
//  AttrRtfd.swift
//  AttrKit
//
//  Created by 韩钢 on 2021/7/6.
//  Copyright © 2021 NickMeepo. All rights reserved.
//

import Foundation

/** A class to convert rtfd file data to NSAttributedString.
 
        AttrRtfd(data)?.attr
 
*/
public class AttrRtfd {

    public let rawAttributedString: NSAttributedString

    public init?(_ rtfdData: Data!) {
        if let rtfdData = rtfdData,
           let rawAttributedString = try? NSAttributedString(
            data: rtfdData,
            options: [
                .documentType: NSAttributedString.DocumentType.rtfd
            ],
            documentAttributes: nil) {
            self.rawAttributedString = rawAttributedString
        } else {
            return nil
        }
    }

}
