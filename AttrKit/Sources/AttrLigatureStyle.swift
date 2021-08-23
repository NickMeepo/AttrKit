//
//  AttrLigatureStyle.swift
//  AttrKit
//
//  Created by HanGang on 2020/8/25.
//  Copyright © 2020 NickMeepo. All rights reserved.
//

import Foundation

/** Ligature style in attributed string.

**Enumerations**:
    - **none**: disable any ligature style.
    - **default**: enable default ligature style.
    - **full**: enable full ligature style, unavailable on iOS.
*/
public enum AttrLigatureStyle: Int {

    /// disable any ligature style.
    case none = 0

    /// enable default ligature style.
    case `default` = 1

    #if os(macOS)
    /// enable full ligature style, unavailable on iOS.
    case full = 2
    #endif

}
