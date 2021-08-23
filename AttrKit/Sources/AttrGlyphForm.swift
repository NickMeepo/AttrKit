//
//  AttrGlyphForm.swift
//  AttrKit
//
//  Created by HanGang on 2020/7/9.
//  Copyright © 2020 NickMeepo. All rights reserved.
//

import Foundation

/** Glyph form style in attributed string.

**Enumerations**:
    - **horizontal**: horizontal glyph form.
    - **vertical**: vertical glyph form, unavailable on iOS.
*/
public enum AttrGlyphForm: Int {

    /// horizontal glyph form.
    case horizontal = 0

    #if os(macOS)
    /// vertical glyph form, unavailable on iOS.
    case vertical = 1
    #endif

}
