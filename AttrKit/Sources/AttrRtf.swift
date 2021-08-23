//
//  AttrRtf.swift
//  AttrKit
//
//  Created by 韩钢 on 2021/7/6.
//  Copyright © 2021 NickMeepo. All rights reserved.
//

import Foundation

/** A class to convert rtf file data to NSAttributedString.
 
        AttrRtf(data)?.attr
 
*/
public class AttrRtf {

    public let rawAttributedString: NSAttributedString

    public init?(_ rtfData: Data!) {
        if let rtfData = rtfData,
           let rawAttributedString = try? NSAttributedString(
            data: rtfData,
            options: [
                .documentType: NSAttributedString.DocumentType.rtf
            ],
            documentAttributes: nil) {
            self.rawAttributedString = rawAttributedString
        } else {
            return nil
        }
    }

}
