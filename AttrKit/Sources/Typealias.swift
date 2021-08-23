//
//  Typealias.swift
//  AttrKit
//
//  Created by HanGang on 2020/7/9.
//  Copyright © 2020 NickMeepo. All rights reserved.
//

#if os(iOS) || os(watchOS) || os(tvOS)

import UIKit

public typealias AttrColor          = UIColor

public typealias AttrFont           = UIFont

public typealias AttrFontDescriptor = UIFontDescriptor

public typealias AttrFontTraits     = UIFontDescriptor.SymbolicTraits

public typealias AttrImage          = UIImage

#else

import AppKit

public typealias AttrColor          = NSColor

public typealias AttrFont           = NSFont

public typealias AttrFontDescriptor = NSFontDescriptor

public typealias AttrFontTraits     = NSFontDescriptor.SymbolicTraits

public typealias AttrImage          = NSImage

public typealias AttrCursor         = NSCursor

public typealias AttrTextAlternatives = NSTextAlternatives

public typealias AttrPoint        = NSPoint

#endif

public typealias AttrLineStyle      = NSUnderlineStyle

public typealias AttrParagraphWritingDirection = NSWritingDirection

public typealias AttrParagraphStyle = NSParagraphStyle

public typealias AttrAlignment      = NSTextAlignment

public typealias AttrLineBreakMode  = NSLineBreakMode

public typealias AttrTextTab = NSTextTab

internal typealias AttrShadow = NSShadow

internal typealias AttrTextEffect   = NSAttributedString.TextEffectStyle

internal typealias AttrFloat = CGFloat

internal typealias AttrSize = CGSize
