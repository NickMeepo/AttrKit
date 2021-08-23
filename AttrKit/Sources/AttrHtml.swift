//
//  AttrHtml.swift
//  AttrKit
//
//  Created by 韩钢 on 2021/5/25.
//  Copyright © 2021 NickMeepo. All rights reserved.
//

import Foundation

/** A class to convert html string to NSAttributedString.
 
        AttrHtml(html: aString)?.attr
 
*/
public class AttrHtml {

    public let rawAttributedString: NSAttributedString

    public init?(_ html: String!) {
        if let data = html?.data(using: .utf8),
           let rawAttributedString = try? NSAttributedString(
            data: data,
            options: [
                .documentType: NSAttributedString.DocumentType.html,
                .characterEncoding: String.Encoding.utf8.rawValue
            ],
            documentAttributes: nil) {
            self.rawAttributedString = rawAttributedString
        } else {
            return nil
        }
    }

}
