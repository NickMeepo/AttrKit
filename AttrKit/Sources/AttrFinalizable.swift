//
//  AttrFinalizable.swift
//  AttrKit
//
//  Created by HanGang on 2020/7/9.
//
// swiftlint:disable file_length function_body_length cyclomatic_complexity line_length type_body_length

#if os(iOS) || os(watchOS) || os(tvOS)
import UIKit
#else
import AppKit
#endif

public class AttrFinalizable {

    internal var raw: NSAttributedString

    internal var attributeItems: [AttrItem]

    internal lazy var _result: NSAttributedString = {
        return self.generateResult(endToFromHere: false)
    }()

    internal init(raw: NSAttributedString, attributeItems: [AttrItem] = [] ) {
        self.raw = raw
        self.attributeItems = attributeItems
    }
    
    internal func generateResult(endToFromHere: Bool) -> NSAttributedString {
        let raw = NSMutableAttributedString(attributedString: self.raw)
        raw.beginEditing()
        defer {
            raw.endEditing()
        }

        // same range attributes should be merged.
        var cacheItems: [AttrItem] = []
        var cacheRanges: [NSRange] = []
        
        for item in self.attributeItems {
            if endToFromHere && item.key == .fromHere {
                break
            }

            var changedRanges: [NSRange] = []
            
            switch item.range {
            case .full:
                let length = NSString(string: raw.string).length
                let range = NSRange(location: 0, length: length)
                changedRanges = [range]
                            
            case let .range(loc, len):
                let str = raw.string
                let total = str.count
                let location = loc.clamp(from: 0, into: total - 1)
                let length = len.clamp(from: 0, into: total - location)
                let left = str.index(str.startIndex, offsetBy: location)
                let right = str.index(str.startIndex, offsetBy: location + length)
                let range = str.nsRange(from: left..<right)
                
                changedRanges = [range]

            case let .reverse(loc, len):
                if len < 0 { break }
                let str = raw.string
                let total = str.count
                let end = loc.clamp(from: 0, into: total)
                var length = len
                var start = end - len
                if start < 0 {
                    start = 0
                    length = end
                }
                let left = str.index(str.startIndex, offsetBy: start)
                let right = str.index(str.startIndex, offsetBy: start + length)
                let range = str.nsRange(from: left..<right)
                
                changedRanges = [range]
                            
            case let .match(pattern):
                
                changedRanges = self.fetchMatchRanges(in: raw, pattern: pattern, firstMatch: false)
                
            case let .firstMatch(pattern):
                
                changedRanges = self.fetchMatchRanges(in: raw, pattern: pattern, firstMatch: true)
            
            case let .occur(subString):
                
                changedRanges = self.fetchMatchRanges(in: raw, pattern: "\\Q\(subString)\\E", firstMatch: false)
            
            case let .firstOccur(subString):
                
                changedRanges = self.fetchMatchRanges(in: raw, pattern: "\\Q\(subString)\\E", firstMatch: true)
            
            }
            if cacheRanges.isEmpty {
                cacheRanges = changedRanges
                cacheItems = [item]
            } else if cacheRanges == changedRanges {
                cacheItems.append(item)
            } else {
                self.addAttributes(in: raw, items: cacheItems, ranges: cacheRanges)
                cacheRanges = changedRanges
                cacheItems = [item]
            }
        }
        
        self.addAttributes(in: raw, items: cacheItems, ranges: cacheRanges)
        
        return raw
    }
    
    internal func addAttributes(in raw: NSMutableAttributedString, items: [AttrItem], ranges: [NSRange]) {
        
        var attributes: [NSAttributedString.Key: Any] = [:]
        var paraAttributes: [AttrParaKey: Any] = [:]
                
        func settingAttributes(in range: NSRange) {
            raw.addAttributes(attributes, range: range)
            attributes = [:]
            if paraAttributes.isEmpty {
                return
            }
            var existAttrDict: [(NSMutableParagraphStyle, NSRange)] = []
            raw.enumerateAttribute(.paragraphStyle, in: range, options: []) { value, subRange, _ in
                if let style = value as? NSMutableParagraphStyle {
                    existAttrDict.append((style, subRange))
                } else {
                    existAttrDict.append((NSMutableParagraphStyle(), subRange))
                }
            }
            if existAttrDict.isEmpty {
                existAttrDict = [(NSMutableParagraphStyle(), range)]
            }
            
            for (style, paraRange) in existAttrDict {
                for (key, value) in paraAttributes {
                    switch key {
                    case .alignment:
                        guard let alignment = value as? AttrAlignment else {
                            break
                        }
                        style.alignment = alignment

                    case .lineBreakMode:
                        guard let mode = value as? AttrLineBreakMode else {
                            break
                        }
                        style.lineBreakMode = mode

                    case .lineSpacing:
                        guard let value = value as? AttrNumber else {
                            break
                        }
                        style.lineSpacing = value.attributeFloat

                    case .paragraphSpacing:
                        guard let value = value as? AttrNumber else {
                            break
                        }
                        style.paragraphSpacing = value.attributeFloat
                        
                    case .paragraphSpacingBefore:
                        guard let value = value as? AttrNumber else {
                            break
                        }
                        style.paragraphSpacingBefore = value.attributeFloat
                        
                    case .firstLineHeadIndent:
                        guard let value = value as? AttrNumber else {
                            break
                        }
                        style.firstLineHeadIndent = value.attributeFloat

                    case .headIndent:
                        guard let value = value as? AttrNumber else {
                            break
                        }
                        style.headIndent = value.attributeFloat

                    case .tailIndent:
                        guard let value = value as? AttrNumber else {
                            break
                        }
                        style.tailIndent = value.attributeFloat
                        
                    case .minimumLineHeight:
                        guard let value = value as? AttrNumber else {
                            break
                        }
                        style.minimumLineHeight = value.attributeFloat

                    case .maximumLineHeight:
                        guard let value = value as? AttrNumber else {
                            break
                        }
                        style.maximumLineHeight = value.attributeFloat

                    case .lineHeightMultiple:
                        guard let value = value as? AttrNumber else {
                            break
                        }
                        style.lineHeightMultiple = value.attributeFloat

                    case .hyphenationFactor:
                        guard let value = value as? AttrNumber else {
                            break
                        }
                        style.hyphenationFactor = Float(value.attributeFloat)

                    case .baseWritingDirection:
                        guard let direction = value as? AttrParagraphWritingDirection else {
                            break
                        }
                        style.baseWritingDirection = direction

                    case .allowsDefaultTighteningForTruncation:
                        guard let enabled = value as? Bool else {
                            break
                        }
                        style.allowsDefaultTighteningForTruncation = enabled

                    case .defaultTabInterval:
                        guard let value = value as? AttrNumber else {
                            break
                        }
                        style.defaultTabInterval = value.attributeFloat

                    case .addTabStop:
                        guard let value = value as? AttrTextTab else {
                            break
                        }
                        style.addTabStop(value)

                    case .removeTabStop:
                        guard let value = value as? AttrTextTab else {
                            break
                        }
                        style.removeTabStop(value)
                        
                    #if os(macOS)
                    case .tighteningFactorForTruncation:
                        guard let value = value as? AttrNumber else {
                            break
                        }
                        style.tighteningFactorForTruncation = Float(value.attributeFloat)
                    #endif
                    }
                }
                raw.addAttributes([.paragraphStyle: style], range: paraRange)
                raw.fixAttributes(in: paraRange)
            }
            paraAttributes = [:]
        }

        for range in ranges {
            
            for item in items {
                
                switch item.key {
                case .font:
                    if let value = item.value as? AttrFontData {
                        attributes[.font] = value.fontWithTraits()
                    } else {
                        settingAttributes(in: range)
                        raw.removeAttribute(.font, range: range)
                    }
                    
                    
                case .addFontTraits:
                    guard let traitsAdded = item.value as? AttrFontTraits else {
                        break
                    }
                    settingAttributes(in: range)
                    let existAttrDict: [(AttrFont, NSRange)] = raw.fetchAttributes(in: range, key: .font)
                    if existAttrDict.isEmpty {
                        // No specified font attributes is found.
                        break
                    }
                    existAttrDict.forEach { existentFont, existentRange in
                        if let value = AttrFontData(font: existentFont, traits: traitsAdded)?.fontWithTraits() {
                            raw.addAttributes([.font: value], range: existentRange)
                        }
                    }
                    raw.fixAttributes(in: range)

                case .removeFontTraits:
                    guard let traitsRemoved = item.value as? AttrFontTraits else {
                        break
                    }
                    settingAttributes(in: range)
                    let existAttrDict: [(AttrFont, NSRange)] = raw.fetchAttributes(in: range, key: .font)
                    if existAttrDict.isEmpty {
                        // No specified font attributes is found.
                        break
                    }
                    existAttrDict.forEach { existentFont, existentRange in
                        if let value = AttrFontData(font: existentFont, traits: traitsRemoved)?.fontWithoutTraits() {
                            raw.addAttributes([.font: value], range: existentRange)
                        }
                    }
                    raw.fixAttributes(in: range)

                case .changeFontSize:
                    guard let value = item.value as? AttrNumber else {
                        break
                    }
                    settingAttributes(in: range)
                    let existAttrDict: [(AttrFont, NSRange)] = raw.fetchAttributes(in: range, key: .font)
                    if existAttrDict.isEmpty {
                        // No specified font attributes is found.
                        break
                    }
                    existAttrDict.forEach { existentFont, existentRange in
                        let font = existentFont.changeSize(value.attributeFloat)
                        raw.addAttributes([.font: font], range: existentRange)
                    }
                    raw.fixAttributes(in: range)

                case .underline:
                    if let value = item.value as? AttrLineData {
                        attributes[.underlineStyle] = value.style.rawNumber
                        attributes[.underlineColor] = value.color
                    } else {
                        settingAttributes(in: range)
                        raw.removeAttribute(.underlineStyle, range: range)
                        raw.removeAttribute(.underlineColor, range: range)
                    }

                case .strikethrough:
                    if let value = item.value as? AttrLineData {
                        attributes[.strikethroughColor] = value.color
                        attributes[.strikethroughStyle] = value.style.rawNumber
                    } else {
                        settingAttributes(in: range)
                        raw.removeAttribute(.strikethroughStyle, range: range)
                        raw.removeAttribute(.strikethroughColor, range: range)
                    }
                    

                case .foreground:
                    if let color = item.value as? AttrColor {
                        attributes[.foregroundColor] = color
                    } else {
                        settingAttributes(in: range)
                        raw.removeAttribute(.foregroundColor, range: range)
                    }

                case .background:
                    if let color = item.value as? AttrColor {
                        attributes[.backgroundColor] = color
                    } else {
                        settingAttributes(in: range)
                        raw.removeAttribute(.backgroundColor, range: range)
                    }
                    
                case .stroke:
                    if let value = item.value as? AttrStrokeData {
                        attributes[.strokeColor] = value.color
                        attributes[.strokeWidth] = value.width.rawNumber
                    } else {
                        settingAttributes(in: range)
                        raw.removeAttribute(.strokeColor, range: range)
                        raw.removeAttribute(.strokeWidth, range: range)
                    }

                case .ligature:
                    guard let style = item.value as? AttrLigatureStyle else {
                        break
                    }
                    attributes[.ligature] = style.rawNumber

                case .kern:
                    guard let value = item.value as? AttrNumber else {
                        break
                    }
                    attributes[.kern] = value.rawNumber

                case .expansion:
                    guard let value = item.value as? AttrNumber else {
                        break
                    }
                    attributes[.expansion] = value.rawNumber

                case .shadow:
                    if let value = item.value as? AttrShadowData {
                        attributes[.shadow] = value.shadow
                    } else {
                        settingAttributes(in: range)
                        raw.removeAttribute(.shadow, range: range)
                    }

                case .textEffect:
                    guard let style = item.value as? AttrTextEffect else {
                        break
                    }
                    attributes[.textEffect] = style

                case .obliqueness:
                    guard let value = item.value as? AttrNumber else {
                        break
                    }
                    attributes[.obliqueness] = value.rawNumber

                case .baseline:
                    guard let value = item.value as? AttrNumber else {
                        break
                    }
                    attributes[.baselineOffset] = value.rawNumber

                case .link:
                    if let value = item.value as? AttrAnyLink {
                        attributes[.link] = value.url
                    } else {
                        settingAttributes(in: range)
                        raw.removeAttribute(.link, range: range)
                    }

                case .writingDirection:
                    guard let direction = item.value as? AttrWritingDirection else {
                        break
                    }
                    attributes[.writingDirection] = [direction.rawNumber]

                case .glyphForm:
                    guard let glyphForm = item.value as? AttrGlyphForm else {
                        break
                    }
                    attributes[.verticalGlyphForm] = glyphForm.rawNumber

                case .erased:
                    guard let types = item.value as? AttrErasedType else {
                        break
                    }
                    settingAttributes(in: range)
                    self.eraseAttributes(in: raw, erasedTypes: types, range: range)

                case .fixed:
                    settingAttributes(in: range)
                    raw.fixAttributes(in: range)

                case .style:
                    guard let data = item.value as? AttrStyleData else {
                        break
                    }
                    settingAttributes(in: range)
                    raw.addAttributes(data.dictionary, range: range)
                
                case .alignment:
                    paraAttributes[.alignment] = item.value

                case .lineBreakMode:
                    paraAttributes[.lineBreakMode] = item.value

                case .lineSpacing:
                    paraAttributes[.lineSpacing] = item.value

                case .paragraphSpacing:
                    paraAttributes[.paragraphSpacing] = item.value
                    
                case .paragraphSpacingBefore:
                    paraAttributes[.paragraphSpacingBefore] = item.value

                case .firstLineHeadIndent:
                    paraAttributes[.firstLineHeadIndent] = item.value

                case .headIndent:
                    paraAttributes[.headIndent] = item.value

                case .tailIndent:
                    paraAttributes[.tailIndent] = item.value

                case .minimumLineHeight:
                    paraAttributes[.minimumLineHeight] = item.value
                    
                case .maximumLineHeight:
                    paraAttributes[.maximumLineHeight] = item.value

                case .lineHeightMultiple:
                    paraAttributes[.lineHeightMultiple] = item.value

                case .hyphenationFactor:
                    paraAttributes[.hyphenationFactor] = item.value

                case .baseWritingDirection:
                    paraAttributes[.baseWritingDirection] = item.value

                case .allowsDefaultTighteningForTruncation:
                    paraAttributes[.allowsDefaultTighteningForTruncation] = item.value

                case .defaultTabInterval:
                    paraAttributes[.defaultTabInterval] = item.value

                case .addTabStop:
                    paraAttributes[.addTabStop] = item.value

                case .removeTabStop:
                    paraAttributes[.removeTabStop] = item.value
                    
                #if os(macOS)
                case .cursor:
                    guard let cursor = item.value as? AttrCursor else {
                        break
                    }
                    attributes[.cursor] = cursor
                    
                case .markedClauseSegment:
                    guard let value = item.value as? AttrNumber else {
                        break
                    }
                    attributes[.markedClauseSegment] = value.rawNumber
                    
                case .spellingState:
                    guard let value = item.value as? AttrSpellingState else {
                        break
                    }
                    attributes[.spellingState] = value.rawNumber
                    
                case .superScript:
                    guard let value = item.value as? AttrNumber else {
                        break
                    }
                    attributes[.superscript] = value.rawNumber
                    
                case .textAlternatives:
                    guard let value = item.value as? AttrTextAlternatives else {
                        break
                    }
                    attributes[.textAlternatives] = value
                    
                case .toolTip:
                    if let string = item.value as? String {
                        attributes[.toolTip] = string
                    } else {
                        settingAttributes(in: range)
                        raw.removeAttribute(.toolTip, range: range)
                    }
                    
                case .tighteningFactorForTruncation:
                    paraAttributes[.tighteningFactorForTruncation] = item.value
                    
                #endif
                    
                case .fromHere:
                    break
                }
            }
            settingAttributes(in: range)
        }
    }
    
    internal func fetchMatchRanges(in raw: NSMutableAttributedString, pattern: String, firstMatch: Bool) -> [NSRange] {
        guard let rex = try? NSRegularExpression(pattern: pattern, options: []) else { return [] }
        let string = raw.string
        let totalRange = NSRange(location: 0, length: NSString(string: string).length)
        if firstMatch {
            if let match = rex.firstMatch(in: string, options: [], range: totalRange) {
                return [match.range]
            } else {
                return []
            }
        } else {
            var res = [NSRange]()
            rex.matches(in: string, options: [], range: totalRange).forEach { match in
                res.append(match.range)
            }
            return res
        }
    }
    
    internal func eraseAttributes(in raw: NSMutableAttributedString, erasedTypes: AttrErasedType, range: NSRange) {
        if erasedTypes.contains(.font) {
            raw.removeAttribute(.font, range: range)
        }
        if erasedTypes.contains(.underline) {
            raw.removeAttribute(.underlineColor, range: range)
            raw.removeAttribute(.underlineStyle, range: range)
        }
        if erasedTypes.contains(.strikethrough) {
            raw.removeAttribute(.strikethroughColor, range: range)
            raw.removeAttribute(.strikethroughStyle, range: range)
        }
        if erasedTypes.contains(.foreground) {
            raw.removeAttribute(.foregroundColor, range: range)
        }
        if erasedTypes.contains(.background) {
            raw.removeAttribute(.backgroundColor, range: range)
        }
        if erasedTypes.contains(.stroke) {
            raw.removeAttribute(.strokeColor, range: range)
            raw.removeAttribute(.strokeWidth, range: range)
        }
        if erasedTypes.contains(.paragraph) {
            raw.removeAttribute(.paragraphStyle, range: range)
        }
        if erasedTypes.contains(.ligature) {
            raw.removeAttribute(.ligature, range: range)
        }
        if erasedTypes.contains(.kern) {
            raw.removeAttribute(.kern, range: range)
        }
        if erasedTypes.contains(.expansion) {
            raw.removeAttribute(.expansion, range: range)
        }
        if erasedTypes.contains(.shadow) {
            raw.removeAttribute(.shadow, range: range)
        }
        if erasedTypes.contains(.textEffect) {
            raw.removeAttribute(.textEffect, range: range)
        }
        if erasedTypes.contains(.obliqueness) {
            raw.removeAttribute(.obliqueness, range: range)
        }
        if erasedTypes.contains(.baseline) {
            raw.removeAttribute(.baselineOffset, range: range)
        }
        if erasedTypes.contains(.link) {
            raw.removeAttribute(.link, range: range)
        }
        if erasedTypes.contains(.attachment) {
            raw.removeAttribute(.attachment, range: range)
        }
        if erasedTypes.contains(.writingDirection) {
            raw.removeAttribute(.writingDirection, range: range)
        }
        if erasedTypes.contains(.glyphForm) {
            raw.removeAttribute(.verticalGlyphForm, range: range)
        }
        if erasedTypes != .none {
            raw.fixAttributes(in: range)
        }
    }

    #if os(macOS)
    internal func generateHtml(excludedElements: [String] = [], prefixSpaces: Int = 0) -> String? {
        let encoding = String.Encoding.utf8
        var documentAttributes: [NSAttributedString.DocumentAttributeKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: encoding.rawValue,
            .prefixSpaces: NSNumber(integerLiteral: prefixSpaces)
        ]
        if !excludedElements.isEmpty {
            documentAttributes[.excludedElements] = excludedElements
        }
        let raw = self.generateResult(endToFromHere: false)
        let range = NSRange(location: 0, length: raw.length)
        guard let export = try? raw.data(from: range, documentAttributes: documentAttributes) else { return nil }
        return String(data: export, encoding: encoding)
    }
    #else
    internal func generateHtml() -> String? {
        let encoding = String.Encoding.utf8
        let documentAttributes: [NSAttributedString.DocumentAttributeKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: encoding.rawValue
        ]
        let raw = self.generateResult(endToFromHere: false)
        let range = NSRange(location: 0, length: raw.length)
        guard let export = try? raw.data(from: range, documentAttributes: documentAttributes) else { return nil }
        return String(data: export, encoding: encoding)
    }
    #endif
    
    internal func generateRtf(includeAttachments: Bool, documentAttributes appendix: [NSAttributedString.DocumentAttributeKey: Any]?) -> Data? {
        let length = NSString(string: raw.string).length
        let range = NSRange(location: 0, length: length)
        let type: NSAttributedString.DocumentType = includeAttachments ? .rtfd : .rtf
        var documentAttributes: [NSAttributedString.DocumentAttributeKey: Any]
        if let appendix = appendix, !appendix.isEmpty {
            documentAttributes = appendix
            documentAttributes[.documentType] = type
        } else {
            documentAttributes = [
                .documentType: type
            ]
        }
        return try? self.result().data(from: range, documentAttributes: documentAttributes)
    }
    
}

public extension AttrFinalizable {

    /// Get final NSAttributedString.
    func result() -> NSAttributedString {
        self._result
    }
    
    #if os(macOS)
    /// Get html transformed.
    ///
    /// - Parameter excludedElements: Array of , representing HTML elements not to be used in generated HTML. default [].
    /// - Parameter prefixSpaces: number of spaces per level by which to indent certain nested HTML elements. default 0.
    func html(excludedElements: [String] = [], prefixSpaces: Int = 0) -> String? {
        self.generateHtml(excludedElements: excludedElements, prefixSpaces: prefixSpaces)
    }
    #else
    /// Get html transformed.
    func html() -> String? {
        self.generateHtml()
    }
    #endif
    
    /// Get rtf file data transformed.
    ///
    /// - Parameter documentAttributes: appended document attributes, default nil.
    func rtf(documentAttributes: [NSAttributedString.DocumentAttributeKey: Any]? = nil) -> Data? {
        self.generateRtf(includeAttachments: false, documentAttributes: documentAttributes)
    }
    
    /// Get rtfd file data transformed.
    ///
    /// - Parameter documentAttributes: appended document attributes, default nil.
    func rtfd(documentAttributes: [NSAttributedString.DocumentAttributeKey: Any]? = nil) -> Data? {
        self.generateRtf(includeAttachments: true, documentAttributes: documentAttributes)
    }

}
