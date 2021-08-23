//
//  AttrStyleExtendable.swift
//  AttrKit
//
//  Created by 韩钢 on 2021/6/3.
//  Copyright © 2021 NickMeepo. All rights reserved.
//

#if os(iOS) || os(watchOS) || os(tvOS)
import UIKit
#else
import AppKit
#endif

public class AttrStyleExtendable {

    internal var attributeItems: [AttrStyleItem]
    
    internal lazy var paragraphStyle: NSMutableParagraphStyle = {
        self.paragraphStyleSetted = true
        return NSMutableParagraphStyle()
    }()
    
    internal var paragraphStyleSetted = false

    internal init(attributeItems: [AttrStyleItem] = [] ) {
        self.attributeItems = attributeItems
    }
    
    internal func generateResult() -> [NSAttributedString.Key: Any] {
        var result = [NSAttributedString.Key: Any]()
        for item in self.attributeItems {
            switch item.key {

            case .font:
                if let value = item.value as? AttrFontData {
                    result[.font] = value.fontWithTraits()
                }
                
            case .alignment:
                if let alignment = item.value as? AttrAlignment {
                    paragraphStyle.alignment = alignment
                }

            case .lineBreakMode:
                if let mode = item.value as? AttrLineBreakMode {
                    paragraphStyle.lineBreakMode = mode
                }

            case .lineSpacing:
                if let value = item.value as? AttrNumber {
                    paragraphStyle.lineSpacing = value.attributeFloat
                }

            case .paragraphSpacing:
                if let value = item.value as? AttrNumber {
                    paragraphStyle.paragraphSpacingBefore = value.attributeFloat
                }

            case .paragraphSpacingBefore:
                if let value = item.value as? AttrNumber {
                    paragraphStyle.paragraphSpacingBefore = value.attributeFloat
                }

            case .firstLineHeadIndent:
                if let value = item.value as? AttrNumber {
                    paragraphStyle.firstLineHeadIndent = value.attributeFloat
                }

            case .headIndent:
                if let value = item.value as? AttrNumber {
                    paragraphStyle.headIndent = value.attributeFloat
                }

            case .tailIndent:
                if let value = item.value as? AttrNumber {
                    paragraphStyle.tailIndent = value.attributeFloat
                }

            case .minimumLineHeight:
                if let value = item.value as? AttrNumber {
                    paragraphStyle.minimumLineHeight = value.attributeFloat
                }

            case .maximumLineHeight:
                if let value = item.value as? AttrNumber {
                    paragraphStyle.maximumLineHeight = value.attributeFloat
                }

            case .lineHeightMultiple:
                if let value = item.value as? AttrNumber {
                    paragraphStyle.lineHeightMultiple = value.attributeFloat
                }

            case .hyphenationFactor:
                if let value = item.value as? AttrNumber {
                    paragraphStyle.hyphenationFactor = Float(value.attributeFloat)
                }

            case .baseWritingDirection:
                if let direction = item.value as? AttrParagraphWritingDirection {
                    paragraphStyle.baseWritingDirection = direction
                }

            case .allowsDefaultTighteningForTruncation:
                if let enabled = item.value as? Bool {
                    paragraphStyle.allowsDefaultTighteningForTruncation = enabled
                }

            case .defaultTabInterval:
                if let value = item.value as? AttrNumber {
                    paragraphStyle.defaultTabInterval = value.attributeFloat
                }

            case .addTabStop:
                if let value = item.value as? AttrTextTab {
                    paragraphStyle.addTabStop(value)
                }

            case .removeTabStop:
                if let value = item.value as? AttrTextTab {
                    paragraphStyle.removeTabStop(value)
                }

            case .underline:
                if let value = item.value as? AttrLineData {
                    result[.underlineColor] = value.color
                    result[.underlineStyle] = value.style.rawNumber
                } else {
                    result[.underlineColor] = nil
                    result[.underlineStyle] = nil
                }

            case .strikethrough:
                if let value = item.value as? AttrLineData {
                    result[.strikethroughColor] = value.color
                    result[.strikethroughStyle] = value.style.rawNumber
                } else {
                    result[.strikethroughColor] = nil
                    result[.strikethroughStyle] = nil
                }

            case .foreground:
                if let color = item.value as? AttrColor {
                    result[.foregroundColor] = color
                } else {
                    result[.foregroundColor] = nil
                }

            case .background:
                if let color = item.value as? AttrColor {
                    result[.backgroundColor] = color
                } else {
                    result[.backgroundColor] = nil
                }

            case .stroke:
                if let value = item.value as? AttrStrokeData {
                    result[.strokeColor] = value.color
                    result[.strokeWidth] = value.width.rawNumber
                } else {
                    result[.strokeColor] = nil
                    result[.strokeWidth] = nil
                }

            case .ligature:
                if let style = item.value as? AttrLigatureStyle {
                    result[.ligature] = style.rawNumber
                }

            case .kern:
                if let value = item.value as? AttrNumber {
                    result[.kern] = value.rawNumber
                }

            case .expansion:
                if let value = item.value as? AttrNumber {
                    result[.expansion] = value.rawNumber
                }

            case .shadow:
                if let value = item.value as? AttrShadowData {
                    result[.shadow] = value.shadow
                } else {
                    result[.shadow] = nil
                }

            case .textEffect:
                if let style = item.value as? AttrTextEffect {
                    result[.textEffect] = style
                }

            case .obliqueness:
                if let value = item.value as? AttrNumber {
                    result[.obliqueness] = value.rawNumber
                }

            case .baseline:
                if let value = item.value as? AttrNumber {
                    result[.baselineOffset] = value.rawNumber
                }

            case .writingDirection:
                if let direction = item.value as? AttrWritingDirection {
                    result[.writingDirection] = [direction.rawNumber]
                }

            case .glyphForm:
                if let glyphForm = item.value as? AttrGlyphForm {
                    result[.verticalGlyphForm] = glyphForm.rawNumber
                }
            
            #if os(macOS)
            case .cursor,
                 .markedClauseSegment,
                .spellingState,
                .superScript,
                .textAlternatives,
                .toolTip,
                .tighteningFactorForTruncation:
                break
            #endif
                
            case .addFontTraits,
                 .removeFontTraits,
                 .changeFontSize,
                 .link,
                 .erased,
                 .fixed,
                 .fromHere,
                 .style:
                break
            
            }
            if self.paragraphStyleSetted {
                result[.paragraphStyle] = self.paragraphStyle
            }
        }
        return result
    }
    
    internal func withAttr(_ key: AttrKey, value: AttrGeneralData?) -> AttrStyleExtendable {
        let result = AttrStyleExtendable(attributeItems: self.attributeItems)
        let item = AttrStyleItem(key, value: value)
        result.attributeItems.append(item)
        return result
    }
    
}

public extension AttrStyleExtendable {

    /// Get final [NSAttributedString.Key: Any].
    func attributes() -> [NSAttributedString.Key: Any] {
        self.generateResult()
    }

    /** Set given font and font traits.
    
    - Parameter specified: a given font.
    - Parameter traits: OptionSet of font traits.
    */
    func font(_ specified: AttrFont, traits: AttrFontTraits? = nil) -> AttrStyleExtendable {
        self.withAttr(.font, value: AttrFontData(font: specified, traits: traits))
    }

    /** Set font given font name and font traits.
    
    - Parameter name: font name.
    - Parameter size: font size.
    - Parameter traits: OptionSet of font traits.
    */
    func font(name: String, size: AttrNumber, traits: AttrFontTraits? = nil) -> AttrStyleExtendable {
        self.withAttr(.font, value: AttrFontData(font: AttrFont(name: name, size: size.nonNegative), traits: traits))
    }

    /** Set font with given font descriptor and font size.
    
    - Parameter descriptor: a given font descriptor.
    - Parameter size: font size.
    */
    func font(descriptor: AttrFontDescriptor, size: AttrNumber) -> AttrStyleExtendable {
        self.withAttr(.font, value: AttrFontData(font: AttrFont(descriptor: descriptor, size: size.nonNegative), traits: nil))
    }

    /** Set systemFont with given size and font traits.
    
    - Parameter size: font size of system font.
    - Parameter traits: OptionSet of system font`s traits.
    */
    func systemFont(size: AttrNumber, traits: AttrFontTraits) -> AttrStyleExtendable {
        self.font(AttrFont.systemFont(ofSize: size.attributeFloat), traits: traits)
    }

    /** Set systemFont with given size and font weight.
    
    - Parameter size: font size of system font.
    - Parameter weight: font weight of system font.
    */
    func systemFont(size: AttrNumber, weight: AttrFont.Weight = .regular) -> AttrStyleExtendable {
        self.font(AttrFont.systemFont(ofSize: size.attributeFloat, weight: weight), traits: nil)
    }

    /** Set bold systemFont with given size.
    
    - Parameter size: font size of system bold font.
    */
    func boldSystemFont(size: AttrNumber) -> AttrStyleExtendable {
        self.font(AttrFont.boldSystemFont(ofSize: size.attributeFloat))
    }

    #if os(iOS) || os(watchOS) || os(tvOS)
    /** Set italic systemFont with given size.
    
    - Parameter size: font size of italic systemFont.
    */
    func italicSystemFont(size: AttrNumber) -> AttrStyleExtendable {
        self.font(AttrFont.italicSystemFont(ofSize: size.attributeFloat))
    }

    /** Set monospaced systemFont with given size and weight.
    
    - Parameter size: font size of monospaced systemFont.
    - Parameter weight: font weight of monospaced systemFont.
    */
    @available(iOS 13.0, *) @available(watchOS 5.0, *) @available(tvOS 13.0, *)
    func monospacedSystemFont(size: AttrNumber, weight: AttrFont.Weight = .regular) -> AttrStyleExtendable {
        self.font(AttrFont.monospacedSystemFont(ofSize: size.attributeFloat, weight: weight))
    }

    /** Set monospaced digit systemFont with given size and weight.
    
    - Parameter size: font size of monospaced systemFont.
    - Parameter weight: font weight of monospaced systemFont.
    */
    func monospacedDigitSystemFont(size: AttrNumber, weight: AttrFont.Weight = .regular) -> AttrStyleExtendable {
        self.font(AttrFont.monospacedDigitSystemFont(ofSize: size.attributeFloat, weight: weight))
    }

    /** Set preferred font with given style.
    
    - Parameter style: style of preferred font.
    */
    func preferredFont(style: AttrFont.TextStyle) -> AttrStyleExtendable {
        self.font(AttrFont.preferredFont(forTextStyle: style))
    }
    #endif
    
    /** Set foreground color of text.
    
    - Parameter color: foreground color. setting nil to erase this attribute.
    */
    func foreground(color: AttrColor?) -> AttrStyleExtendable {
        self.withAttr(.foreground, value: color)
    }

    /** Set background color of text.
    
    - Parameter color: background color. setting nil to erase this attribute.
    */
    func background(color: AttrColor?) -> AttrStyleExtendable {
        self.withAttr(.background, value: color)
    }

    /** Set underline of text with given style and color.
    
    - Parameter style: OptionSet of line style.
    - Parameter color: line color. setting nil to erase this attribute.
    */
    func underline(style: AttrLineStyle = .single, color: AttrColor? = .black) -> AttrStyleExtendable {
        self.withAttr(.underline, value: AttrLineData(color: color, style: style))
    }

    /** Set strikethrough of text with given style and color.

    - Parameter style: OptionSet of line style.
    - Parameter color: line color. setting nil to erase this attribute.
    */
    func strikethrough(style: AttrLineStyle = .single, color: AttrColor? = .black) -> AttrStyleExtendable {
        self.withAttr(.strikethrough, value: AttrLineData(color: color, style: style))
    }

    /** Set stroke appearence of text with given color and width.
    
    - Parameter color: stroke color. setting nil to erase this attribute.
    - Parameter width: stroke width. could be negative.
    */
    func stroke(color: AttrColor?, width: AttrNumber) -> AttrStyleExtendable {
        self.withAttr(.stroke, value: AttrStrokeData(color: color, width: width))
    }

    /** Set kern of text.
    
    - Parameter points: kerning in points. coule be negative.
    */
    func kern(_ points: AttrNumber) -> AttrStyleExtendable {
        self.withAttr(.kern, value: points.attributeFloat)
    }

    /** Set expansion of text.
    
    - Parameter level: expansion level, log of expansion factor to be applied to glyphs. coule be negative.
    */
    func expansion(_ level: AttrNumber) -> AttrStyleExtendable {
        self.withAttr(.expansion, value: level.attributeFloat)
    }

    /** Set obliqueness of text.
    
    - Parameter level: obliqueness level. Oblique to right when value > 0 otherwise oblique to left.
    */
    func obliqueness(_ level: AttrNumber) -> AttrStyleExtendable {
        self.withAttr(.obliqueness, value: level.attributeFloat)
    }

    /** Set baselineOffset of text.
    
    - Parameter value: baseline offset. Offset to top when offset > 0 otherwise offset to bottom.
    */
    func baselineOffset(_ value: AttrNumber) -> AttrStyleExtendable {
        self.withAttr(.baseline, value: value.attributeFloat)
    }

    /** Set shadow appearence of text with given offset, blurRadius and color.
    
    - Parameter x: shadow offset on X axis. could be negative.
    - Parameter y: shadow offset on Y axis. could be negative.
    - Parameter radius: shadow radius. could be negative.
    - Parameter color: shadow color. setting nil to erase this attribute.
    */
    func shadow(x: AttrNumber, y: AttrNumber, radius: AttrNumber, color: AttrColor?) -> AttrStyleExtendable {
        self.withAttr(.shadow, value: AttrShadowData(color: color, offset: CGSize(width: x.attributeFloat, height: y.attributeFloat), radius: radius))
    }

    /** Set shadow appearence of text with given offset, blurRadius and color.
    
    - Parameter offset: shadow offset.
    - Parameter radius: shadow radius. could be negative.
    - Parameter color: shadow color. setting nil to erase this attribute.
    */
    func shadow(offset: CGSize, radius: AttrNumber, color: AttrColor?) -> AttrStyleExtendable {
        self.withAttr(.shadow, value: AttrShadowData(color: color, offset: offset, radius: radius))
    }

    /** Set whether text is ligatured if possible.
    
    - ⚠️ Not all fonts support ligature, when set ligature enabled on these fonts, there will be no effect.
    - Parameter style: style of ligature.
    */
    func ligature(style: AttrLigatureStyle) -> AttrStyleExtendable {
        self.withAttr(.ligature, value: style)
    }

    /** Set writing direction of text.
    
    - Parameter direction: writing direction, such as left to right etc.
    */
    func writing(from direction: AttrWritingDirection) -> AttrStyleExtendable {
        self.withAttr(.writingDirection, value: direction)
    }

    /** Set glyph form style of text.
    
    - Parameter style:  horizontal or vertical glyphForm style, but only horizontal is available on iOS.
    */
    func glyphForm(style: AttrGlyphForm) -> AttrStyleExtendable {
        self.withAttr(.glyphForm, value: style)
    }

    /// Set letterpress style textEffect of text.
    func letterpressStyle() -> AttrStyleExtendable {
        self.withAttr(.textEffect, value: AttrTextEffect.letterpressStyle)
    }

    /** Set alignment of paragraph.
    
    - Parameter mode: alignment mode of paragraph.
    */
    func alignment(_ mode: AttrAlignment) -> AttrStyleExtendable {
        self.withAttr(.alignment, value: mode)
    }

    /** Set break mode of paragraph.
    
    - Parameter mode: line break mode of paragraph.
    */
    func lineBreakMode(_ mode: AttrLineBreakMode) -> AttrStyleExtendable {
        self.withAttr(.lineBreakMode, value: mode)
    }

    /** Set the distance between the bottom of one line fragment and top of next (applied between lines in the same container).
    
    This value is included in the line fragment heights in layout manager.
     
    - Parameter spacing: This value is always nonnegative. This value is included in the line fragment heights in the layout manager.
    */
    func lineSpacing(_ spacing: AttrNumber) -> AttrStyleExtendable {
        self.withAttr(.lineSpacing, value: spacing.attributeFloat)
    }

    /** Set the distance between the bottom of this paragraph and top of next (or the beginning of its paragraphSpacingBefore, if any).
    
    - Parameter spacing: This property contains the space (measured in points) added at the end of the paragraph to separate it from the following paragraph. This value must be nonnegative. The space between paragraphs is determined by adding the previous paragraph’s paragraphSpacing and the current paragraph’s paragraphSpacingBefore.
    */
    func paragraphSpacing(_ spacing: AttrNumber) -> AttrStyleExtendable {
        self.withAttr(.paragraphSpacing, value: spacing.attributeFloat)
    }

    /** Set the distance between the bottom of the previous paragraph (or the end of its paragraphSpacing, if any) and the top of this paragraph.
    
    - Parameter spacing: This property contains the space (measured in points) between the paragraph’s top and the beginning of its text content. The default value of this property is 0.0.
    */
    func paragraphSpacingBefore(_ spacing: AttrNumber) -> AttrStyleExtendable {
        self.withAttr(.paragraphSpacingBefore, value: spacing.attributeFloat)
    }

    /** Set the distance from margin to edge appropriate for text direction.
    
    - Parameter indent: This property contains the distance (in points) from the leading margin of a text container to the beginning of the paragraph’s first line. This value is always nonnegative.
    */
    func firstLineHeadIndent(_ indent: AttrNumber) -> AttrStyleExtendable {
        self.withAttr(.firstLineHeadIndent, value: indent.attributeFloat)
    }

    /** Set the distance from margin to front edge of paragraph.
    
    - Parameter indent: This property contains the distance (in points) from the leading margin of a text container to the beginning of lines other than the first. This value is always nonnegative.
    */
    func headIndent(_ indent: AttrNumber) -> AttrStyleExtendable {
        self.withAttr(.headIndent, value: indent.attributeFloat)
    }

    /** Set the distance from margin to back edge of paragraph.
    
    - Parameter indent: If positive, this value is the distance from the leading margin (for example, the left margin in left-to-right text). If 0 or negative, it’s the distance from the trailing margin.
    */
    func tailIndent(_ indent: AttrNumber) -> AttrStyleExtendable {
        self.withAttr(.tailIndent, value: indent.attributeFloat)
    }

    /** Set the distance from bottom of descenders to top of ascenders, basically the line fragment height.
    
    Does not include lineSpacing (which is added after this computation).
    
    - Parameter height: This property contains the minimum height in points that any line in the receiver will occupy, regardless of the font size or size of any attached graphic. This value must be nonnegative.
    */
    func minimumLineHeight(_ height: AttrNumber) -> AttrStyleExtendable {
        self.withAttr(.minimumLineHeight, value: height.attributeFloat)
    }

    /** Set the distance from bottom of descenders to top of ascenders, basically the line fragment height.
    
    Does not include lineSpacing (which is added after this computation).
    
    - Parameter height: height from bottom of descenders to top of ascenders. if 0 implies no maximum.
    */
    func maximumLineHeight(_ height: AttrNumber) -> AttrStyleExtendable {
        self.withAttr(.maximumLineHeight, value: height.attributeFloat)
    }

    /** Set height multiplied by factor (if positive) with natural line height before being constrained by minimum and maximum line height.
    
    - Parameter factor: the factor multiplier.
    */
    func lineHeightMultiple(_ factor: AttrNumber) -> AttrStyleExtendable {
        self.withAttr(.lineHeightMultiple, value: factor.attributeFloat)
    }

    /** Specifies the threshold for hyphenation.
    
    Hyphenation will be attempted when the ratio of the text width as broken without hyphenation to the width of the line fragment is less than the hyphenation factor.
    
    - Parameter factor: factor lies in [0.0, 1.0]. When factor is 0.0, the layout manager's hyphenation factor is used instead. When both are 0.0, hyphenation is disabled.
    */
    func hyphenationFactor(_ factor: AttrNumber) -> AttrStyleExtendable {
        self.withAttr(.hyphenationFactor, value: factor.attributeFloat)
    }

    /** Set base writing direction of this paragraph.
    
    - Parameter direction: base writing direction.
    */
    func baseWritingDirection(_ direction: AttrParagraphWritingDirection) -> AttrStyleExtendable {
        self.withAttr(.baseWritingDirection, value: direction)
    }

    /** Tightens inter-character spacing in attempt to fit lines wider than the available space if the line break mode is one of the truncation modes before starting to truncate.
    
    The maximum amount of tightening performed is determined by the system based on contexts such as font, line width, etc.
    
    - Parameter enable: whether allows default tightening.
    */
    func allowsDefaultTighteningForTruncation(_ enable: Bool) -> AttrStyleExtendable {
        self.withAttr(.allowsDefaultTighteningForTruncation, value: enable)
    }

    /** Set the default tab interval used for locations beyond the last element in tabStops
    
    - Parameter interval: default tab interval of tabStops.
    */
    func defaultTabInterval(_ interval: AttrNumber) -> AttrStyleExtendable {
        self.withAttr(.defaultTabInterval, value: interval.attributeFloat)
    }
    
}
