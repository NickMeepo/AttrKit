//
//  AttrRange.swift
//  AttrKit
//
//  Created by HanGang on 2020/7/9.
//  Copyright © 2020 NickMeepo. All rights reserved.
//

import Foundation

internal enum AttrRange {

    /// denote attributes editing in full range.
    case full

    /// denote attributes editing in range from location with length.
    case range(location: Int, length: Int)

    /// denote attributes editing in range from location with length.
    case reverse(location: Int, length: Int)

    /// denote attributes editing in ranges satisfied RegularExpression.
    case match(pattern: String)

    /// denote attributes editing in range first satisfied RegularExpression.
    case firstMatch(pattern: String)

    /// denote attributes editing in ranges where subString occurs.
    case occur(subString: String)

    /// denote attributes editing in range where subString first occurs.
    case firstOccur(subString: String)

}
