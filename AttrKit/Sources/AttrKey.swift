//
//  AttrKey.swift
//  AttrKit
//
//  Created by HanGang on 2020/7/9.
//  Copyright © 2020 NickMeepo. All rights reserved.
//

import Foundation

internal enum AttrKey {

    case font

    case changeFontSize

    case addFontTraits

    case removeFontTraits

    case alignment

    case lineBreakMode

    case lineSpacing

    case paragraphSpacing

    case paragraphSpacingBefore

    case firstLineHeadIndent

    case headIndent

    case tailIndent

    case minimumLineHeight

    case maximumLineHeight

    case lineHeightMultiple

    case hyphenationFactor

    case baseWritingDirection

    case allowsDefaultTighteningForTruncation

    case defaultTabInterval

    case addTabStop

    case removeTabStop

    case underline

    case strikethrough

    case foreground

    case background

    case stroke

    case ligature

    case kern

    case expansion

    case shadow

    case textEffect

    case obliqueness

    case baseline

    case link

    case writingDirection

    case glyphForm

    case erased

    case fixed

    case fromHere
    
    case style

    #if os(macOS)
    case cursor
    
    case markedClauseSegment

    case spellingState
    
    case superScript

    case textAlternatives

    case toolTip
    
    case tighteningFactorForTruncation
    
    /// The name of a glyph info object.
    /// The NSLayoutManager object assigns the glyph specified by this NSGlyphInfo object to the entire attribute range, provided that its contents match the specified base string, and that the specified glyph is available in the font specified by NSFontAttributeName.
//    case glyphInfo
    #endif
    
}
