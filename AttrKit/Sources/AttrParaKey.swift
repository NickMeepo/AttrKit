//
//  AttrParaKey.swift
//  AttrKit
//
//  Created by 韩钢 on 2021/8/17.
//  Copyright © 2021 NickMeepo. All rights reserved.
//

import Foundation

internal enum AttrParaKey {
    
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
    
    #if os(macOS)
    case tighteningFactorForTruncation
    #endif
    
}
