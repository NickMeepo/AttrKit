//
//  AttrGeneralData.swift
//  AttrKit
//
//  Created by HanGang on 2020/7/9.
//  Copyright © 2020 NickMeepo. All rights reserved.
//

import Foundation

internal protocol AttrGeneralData { }

extension Bool: AttrGeneralData { }

extension Int: AttrGeneralData { }

extension Float: AttrGeneralData { }

extension Double: AttrGeneralData { }

extension NSNumber: AttrGeneralData { }

extension AttrFloat: AttrGeneralData { }

extension AttrAnyLink: AttrGeneralData { }

extension AttrTextTab: AttrGeneralData { }

extension AttrLigatureStyle: AttrGeneralData { }

extension AttrLineData: AttrGeneralData { }

extension AttrStrokeData: AttrGeneralData { }

extension AttrShadowData: AttrGeneralData { }

extension AttrFontData: AttrGeneralData { }

extension AttrFontTraits: AttrGeneralData { }

extension AttrColor: AttrGeneralData { }

extension AttrTextEffect: AttrGeneralData { }

extension AttrGlyphForm: AttrGeneralData { }

extension AttrWritingDirection: AttrGeneralData { }

extension AttrParagraphWritingDirection: AttrGeneralData { }

extension AttrAlignment: AttrGeneralData { }

extension AttrLineBreakMode: AttrGeneralData { }

extension AttrErasedType: AttrGeneralData { }

extension AttrStyleData: AttrGeneralData { }

#if os(macOS)
extension String: AttrGeneralData { }

extension NSString: AttrGeneralData { }

extension AttrCursor: AttrGeneralData { }

extension AttrSpellingState: AttrGeneralData { }

extension AttrTextAlternatives: AttrGeneralData { }
#endif
