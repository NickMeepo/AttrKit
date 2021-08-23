//
//  AttrExtendable.swift
//  AttrKit
//
//  Created by HanGang on 2020/7/10.
//
// swiftlint:disable file_length line_length identifier_name

#if os(iOS) || os(watchOS) || os(tvOS)
import UIKit
#else
import AppKit
#endif

public class AttrExtendable: AttrFinalizable {

    internal func withAttr(_ key: AttrKey, value: AttrGeneralData?) -> AttrRangable {
        let result = AttrRangable(raw: self.raw, attributeItems: self.attributeItems)
        let item = AttrItem(key, value: value)
        result.attributeItems.append(item)
        return result
    }

    internal func splitFromHere(with other: AttrSupportedType) -> (originalResult: NSAttributedString, otherPart: AttrExtendable) {
        let chain = other.attr
        if let lastFromHere = self.attributeItems.lastIndex(where: { $0.key == .fromHere }) {
            for index in stride(from: lastFromHere + 1, to: self.attributeItems.count, by: 1) {
                chain.attributeItems.append(self.attributeItems[index])
            }
        }
        let originalResult = self.generateResult(endToFromHere: true)
        return (originalResult, chain)
    }

}

// MARK: Font Attributes
public extension AttrExtendable {

    /** Set given font and font traits.
    
    - Parameter specified: a given font.
    - Parameter traits: OptionSet of font traits.
    */
    func font(_ specified: AttrFont, traits: AttrFontTraits? = nil) -> AttrRangable {
        self.withAttr(.font, value: AttrFontData(font: specified, traits: traits))
    }

    /** Set font given font name and font traits.
    
    - Parameter name: font name.
    - Parameter size: font size.
    - Parameter traits: OptionSet of font traits.
    */
    func font(name: String, size: AttrNumber, traits: AttrFontTraits? = nil) -> AttrRangable {
        self.withAttr(.font, value: AttrFontData(font: AttrFont(name: name, size: size.nonNegative), traits: traits))
    }

    /** Set font with given font descriptor and font size.
    
    - Parameter descriptor: a given font descriptor.
    - Parameter size: font size.
    */
    func font(descriptor: AttrFontDescriptor, size: AttrNumber) -> AttrRangable {
        self.withAttr(.font, value: AttrFontData(font: AttrFont(descriptor: descriptor, size: size.nonNegative), traits: nil))
    }

    /** Set systemFont with given size and font traits.
    
    - Parameter size: font size of system font.
    - Parameter traits: OptionSet of system font`s traits.
    */
    func systemFont(size: AttrNumber, traits: AttrFontTraits) -> AttrRangable {
        self.font(AttrFont.systemFont(ofSize: size.attributeFloat), traits: traits)
    }

    /** Set systemFont with given size and font weight.
    
    - Parameter size: font size of system font.
    - Parameter weight: font weight of system font.
    */
    func systemFont(size: AttrNumber, weight: AttrFont.Weight = .regular) -> AttrRangable {
        self.font(AttrFont.systemFont(ofSize: size.attributeFloat, weight: weight), traits: nil)
    }

    /** Set bold systemFont with given size.
    
    - Parameter size: font size of system bold font.
    */
    func boldSystemFont(size: AttrNumber) -> AttrRangable {
        self.font(AttrFont.boldSystemFont(ofSize: size.attributeFloat))
    }

    #if os(iOS) || os(watchOS) || os(tvOS)
    /** Set italic systemFont with given size.
    
    - Parameter size: font size of italic systemFont.
    */
    func italicSystemFont(size: AttrNumber) -> AttrRangable {
        self.font(AttrFont.italicSystemFont(ofSize: size.attributeFloat))
    }

    /** Set monospaced systemFont with given size and weight.
    
    - Parameter size: font size of monospaced systemFont.
    - Parameter weight: font weight of monospaced systemFont.
    */
    @available(iOS 13.0, *) @available(watchOS 5.0, *) @available(tvOS 13.0, *)
    func monospacedSystemFont(size: AttrNumber, weight: AttrFont.Weight = .regular) -> AttrRangable {
        self.font(AttrFont.monospacedSystemFont(ofSize: size.attributeFloat, weight: weight))
    }

    /** Set monospaced digit systemFont with given size and weight.
    
    - Parameter size: font size of monospaced systemFont.
    - Parameter weight: font weight of monospaced systemFont.
    */
    func monospacedDigitSystemFont(size: AttrNumber, weight: AttrFont.Weight = .regular) -> AttrRangable {
        self.font(AttrFont.monospacedDigitSystemFont(ofSize: size.attributeFloat, weight: weight))
    }

    /** Set preferred font with given style.
    
    - Parameter style: style of preferred font.
    */
    func preferredFont(style: AttrFont.TextStyle) -> AttrRangable {
        self.font(AttrFont.preferredFont(forTextStyle: style))
    }
    #endif

    /** Add given font traits.
    
    - ⚠️ If no font is setted before, there will be no effect.
    - Parameter traits: new OptionSet of traits adding to existent font.
    */
    func withFontTraits(added traits: AttrFontTraits) -> AttrRangable {
        self.withAttr(.addFontTraits, value: traits)
    }

    /** Remove given font traits.
    
    - ⚠️ If no font is setted before, there will be no effect.
    - Parameter traits: OptionSet of traits removing from existent font.
    */
    func withFontTraits(removed traits: AttrFontTraits) -> AttrRangable {
        self.withAttr(.removeFontTraits, value: traits)
    }

    /** Change font pointSize with given value.
    
    - ⚠️ If no font is setted before, there will be no effect.
    - Parameter value: increasing or decreasing value of font pointSize.
    */
    func withFontSize(changed value: AttrNumber) -> AttrRangable {
        self.withAttr(.changeFontSize, value: value.attributeFloat)
    }

}

// MARK: Text Attributes
public extension AttrExtendable {

    /** Set foreground color of text.
    
    - Parameter color: foreground color. setting nil to erase this attribute.
    */
    func foreground(color: AttrColor?) -> AttrRangable {
        self.withAttr(.foreground, value: color)
    }

    /** Set background color of text.
    
    - Parameter color: background color. setting nil to erase this attribute.
    */
    func background(color: AttrColor?) -> AttrRangable {
        self.withAttr(.background, value: color)
    }

    /** Set underline of text with given style and color.
    
    - Parameter style: OptionSet of line style.
    - Parameter color: line color. setting nil to erase this attribute.
    */
    func underline(style: AttrLineStyle = .single, color: AttrColor? = .black) -> AttrRangable {
        self.withAttr(.underline, value: AttrLineData(color: color, style: style))
    }

    /** Set strikethrough of text with given style and color.

    - Parameter style: OptionSet of line style.
    - Parameter color: line color. setting nil to erase this attribute.
    */
    func strikethrough(style: AttrLineStyle = .single, color: AttrColor? = .black) -> AttrRangable {
        self.withAttr(.strikethrough, value: AttrLineData(color: color, style: style))
    }

    /** Set stroke appearence of text with given color and width.
    
    - Parameter color: stroke color. setting nil to erase this attribute.
    - Parameter width: stroke width. could be negative.
    */
    func stroke(color: AttrColor?, width: AttrNumber) -> AttrRangable {
        self.withAttr(.stroke, value: AttrStrokeData(color: color, width: width))
    }

    /** Set kern of text.
    
    - Parameter points: kerning in points. coule be negative.
    */
    func kern(_ points: AttrNumber) -> AttrRangable {
        self.withAttr(.kern, value: points.attributeFloat)
    }

    /** Set expansion of text.
    
    - Parameter level: expansion level, log of expansion factor to be applied to glyphs. coule be negative.
    */
    func expansion(_ level: AttrNumber) -> AttrRangable {
        self.withAttr(.expansion, value: level.attributeFloat)
    }

    /** Set obliqueness of text.
    
    - Parameter level: obliqueness level. Oblique to right when value > 0 otherwise oblique to left.
    */
    func obliqueness(_ level: AttrNumber) -> AttrRangable {
        self.withAttr(.obliqueness, value: level.attributeFloat)
    }

    /** Set baselineOffset of text.
    
    - Parameter value: baseline offset. Offset to top when offset > 0 otherwise offset to bottom.
    */
    func baselineOffset(_ value: AttrNumber) -> AttrRangable {
        self.withAttr(.baseline, value: value.attributeFloat)
    }

    /** Set shadow appearence of text with given offset, blurRadius and color.
    
    - Parameter x: shadow offset on X axis. could be negative.
    - Parameter y: shadow offset on Y axis. could be negative.
    - Parameter radius: shadow radius. could be negative.
    - Parameter color: shadow color. setting nil to erase this attribute.
    */
    func shadow(x: AttrNumber, y: AttrNumber, radius: AttrNumber, color: AttrColor?) -> AttrRangable {
        self.withAttr(.shadow, value: AttrShadowData(color: color, offset: CGSize(width: x.attributeFloat, height: y.attributeFloat), radius: radius))
    }

    /** Set shadow appearence of text with given offset, blurRadius and color.
    
    - Parameter offset: shadow offset.
    - Parameter radius: shadow radius. could be negative.
    - Parameter color: shadow color. setting nil to erase this attribute.
    */
    func shadow(offset: CGSize, radius: AttrNumber, color: AttrColor?) -> AttrRangable {
        self.withAttr(.shadow, value: AttrShadowData(color: color, offset: offset, radius: radius))
    }

    /** Set whether text is ligatured if possible.
    
    - ⚠️ Not all fonts support ligature, when set ligature enabled on these fonts, there will be no effect.
    - Parameter style: style of ligature.
    */
    func ligature(style: AttrLigatureStyle) -> AttrRangable {
        self.withAttr(.ligature, value: style)
    }

    /** Set writing direction of text.
    
    - Parameter direction: writing direction, such as left to right etc.
    */
    func writing(from direction: AttrWritingDirection) -> AttrRangable {
        self.withAttr(.writingDirection, value: direction)
    }

    /** Set glyph form style of text.
    
    - Parameter style:  horizontal or vertical glyphForm style, but only horizontal is available on iOS.
    */
    func glyphForm(style: AttrGlyphForm) -> AttrRangable {
        self.withAttr(.glyphForm, value: style)
    }

    /// Set letterpress style textEffect of text.
    func letterpressStyle() -> AttrRangable {
        self.withAttr(.textEffect, value: AttrTextEffect.letterpressStyle)
    }

    /** Set link url of text.
    
    - Parameter url: link url. setting nil to erase this attribute. Supports:
        - String
        - NSString
        - URL
        - NSURL
    */
    func link(url: AttrURL?) -> AttrRangable {
        self.withAttr(.link, value: AttrAnyLink(url: url?.attributeURL))
    }
    
    #if os(macOS)
    /** Set  cursor object. macOS only.
    
    - Parameter image: image to assign to the cursor.
    - Parameter foregroundColorHint: foreground color. This is currently ignored.
    - Parameter backgroundColorHint: background color. This is currently ignored.
    - Parameter hotSpot: point to assign as the cursor's hot spot.
    */
    func cursor(image: AttrImage, foregroundColorHint: AttrColor? = nil, backgroundColorHint: AttrColor? = nil, hotSpot: AttrPoint) -> AttrRangable {
        self.withAttr(.cursor, value: AttrCursor(image: image, foregroundColorHint: foregroundColorHint, backgroundColorHint: backgroundColorHint, hotSpot: hotSpot))
    }
    
    /** Set  cursor object. macOS only.
    
    - Parameter sepcified: sepcified cursor object.
    */
    func cursor(_ sepcified: AttrCursor) -> AttrRangable {
        self.withAttr(.cursor, value: sepcified)
    }
    
    /** Set  the index of the marked clause segment. macOS only.
    
    - Parameter value: an integer as an index in marked text indicating clause segments.
    */
    func markedClauseSegment(_ value: Int) -> AttrRangable {
        self.withAttr(.markedClauseSegment, value: value)
    }
    
    /** Set the spelling state of the text. macOS only.
     
    - Parameter value: spelling state of the text. default .normal.
     */
    func spellingState(_ value: AttrSpellingState) -> AttrRangable {
        self.withAttr(.spellingState, value: value)
    }
    
    /** Set the superscript of the text. macOS only.
     
    - Parameter value: an integer value indicate the superscript.
     */
    func superScript(_ value: Int) -> AttrRangable {
        self.withAttr(.superScript, value: value)
    }
    
    /** Set the alternatives for a string that may be presented to the user. macOS only.
     
    - Parameter primaryString: text that was initially chosen as the input string.
    - Parameter alternativeStrings: array of alternative possible interpretations that the user might select.
     */
    func textAlternatives(primaryString: String, alternativeStrings: [String]) -> AttrRangable {
        self.withAttr(.textAlternatives, value: AttrTextAlternatives(primaryString: primaryString, alternativeStrings: alternativeStrings))
    }
    
    /** Set the alternatives for a string that may be presented to the user. macOS only.
     
    - Parameter specified: specified textAlternatives object.
     */
    func textAlternatives(_ specified: AttrTextAlternatives) -> AttrRangable {
        self.withAttr(.textAlternatives, value: specified)
    }
    
    /** Set the tooltip text. macOS only.
     
    - Parameter string: tooltip text. default nil.
     */
    func toolTip(_ string: AttrString?) -> AttrRangable {
        self.withAttr(.toolTip, value: string?.rawString)
    }
    
    /** Set the threshold for using tightening as an alternative to truncation. macOS only.
     
    When the line break mode specifies truncation, the text system attempts to tighten inter character spacing as an alternative to truncation, provided that the ratio of the text width to the line fragment width does not exceed 1.0 + the value of tighteningFactorForTruncation. Otherwise the text is truncated at a locaion determined by the line break mode.
     
    - Parameter threshold: the threshold for using tightening as an alternative to truncation. value can be a positive or negative value. Values less than or equal to 0.0 result in not tightening. default 0.05.
     */
    func tighteningFactorForTruncation(threshold: AttrNumber)  -> AttrRangable {
        self.withAttr(.tighteningFactorForTruncation, value: threshold.attributeFloat)
    }
    #endif

}

// MARK: Paragraph Attributes
public extension AttrExtendable {

    /** Set alignment of paragraph.
    
    - Parameter mode: alignment mode of paragraph.
    */
    func alignment(_ mode: AttrAlignment) -> AttrRangable {
        self.withAttr(.alignment, value: mode)
    }

    /** Set break mode of paragraph.
    
    - Parameter mode: line break mode of paragraph.
    */
    func lineBreakMode(_ mode: AttrLineBreakMode) -> AttrRangable {
        self.withAttr(.lineBreakMode, value: mode)
    }

    /** Set the distance between the bottom of one line fragment and top of next (applied between lines in the same container).
    
    This value is included in the line fragment heights in layout manager.
     
    - Parameter spacing: This value is always nonnegative. This value is included in the line fragment heights in the layout manager.
    */
    func lineSpacing(_ spacing: AttrNumber) -> AttrRangable {
        self.withAttr(.lineSpacing, value: spacing.attributeFloat)
    }

    /** Set the distance between the bottom of this paragraph and top of next (or the beginning of its paragraphSpacingBefore, if any).
    
    - Parameter spacing: This property contains the space (measured in points) added at the end of the paragraph to separate it from the following paragraph. This value must be nonnegative. The space between paragraphs is determined by adding the previous paragraph’s paragraphSpacing and the current paragraph’s paragraphSpacingBefore.
    */
    func paragraphSpacing(_ spacing: AttrNumber) -> AttrRangable {
        self.withAttr(.paragraphSpacing, value: spacing.attributeFloat)
    }

    /** Set the distance between the bottom of the previous paragraph (or the end of its paragraphSpacing, if any) and the top of this paragraph.
    
    - Parameter spacing: This property contains the space (measured in points) between the paragraph’s top and the beginning of its text content. The default value of this property is 0.0.
    */
    func paragraphSpacingBefore(_ spacing: AttrNumber) -> AttrRangable {
        self.withAttr(.paragraphSpacingBefore, value: spacing.attributeFloat)
    }

    /** Set the distance from margin to edge appropriate for text direction.
    
    - Parameter indent: This property contains the distance (in points) from the leading margin of a text container to the beginning of the paragraph’s first line. This value is always nonnegative.
    */
    func firstLineHeadIndent(_ indent: AttrNumber) -> AttrRangable {
        self.withAttr(.firstLineHeadIndent, value: indent.attributeFloat)
    }

    /** Set the distance from margin to front edge of paragraph.
    
    - Parameter indent: This property contains the distance (in points) from the leading margin of a text container to the beginning of lines other than the first. This value is always nonnegative.
    */
    func headIndent(_ indent: AttrNumber) -> AttrRangable {
        self.withAttr(.headIndent, value: indent.attributeFloat)
    }

    /** Set the distance from margin to back edge of paragraph.
    
    - Parameter indent: If positive, this value is the distance from the leading margin (for example, the left margin in left-to-right text). If 0 or negative, it’s the distance from the trailing margin.
    */
    func tailIndent(_ indent: AttrNumber) -> AttrRangable {
        self.withAttr(.tailIndent, value: indent.attributeFloat)
    }

    /** Set the distance from bottom of descenders to top of ascenders, basically the line fragment height.
    
    Does not include lineSpacing (which is added after this computation).
    
    - Parameter height: This property contains the minimum height in points that any line in the receiver will occupy, regardless of the font size or size of any attached graphic. This value must be nonnegative.
    */
    func minimumLineHeight(_ height: AttrNumber) -> AttrRangable {
        self.withAttr(.minimumLineHeight, value: height.attributeFloat)
    }

    /** Set the distance from bottom of descenders to top of ascenders, basically the line fragment height.
    
    Does not include lineSpacing (which is added after this computation).
    
    - Parameter height: height from bottom of descenders to top of ascenders. if 0 implies no maximum.
    */
    func maximumLineHeight(_ height: AttrNumber) -> AttrRangable {
        self.withAttr(.maximumLineHeight, value: height.attributeFloat)
    }

    /** Set height multiplied by factor (if positive) with natural line height before being constrained by minimum and maximum line height.
    
    - Parameter factor: the factor multiplier.
    */
    func lineHeightMultiple(_ factor: AttrNumber) -> AttrRangable {
        self.withAttr(.lineHeightMultiple, value: factor.attributeFloat)
    }

    /** Specifies the threshold for hyphenation.
    
    Hyphenation will be attempted when the ratio of the text width as broken without hyphenation to the width of the line fragment is less than the hyphenation factor.
    
    - Parameter factor: factor lies in [0.0, 1.0]. When factor is 0.0, the layout manager's hyphenation factor is used instead. When both are 0.0, hyphenation is disabled.
    */
    func hyphenationFactor(_ factor: AttrNumber) -> AttrRangable {
        self.withAttr(.hyphenationFactor, value: factor.attributeFloat)
    }

    /** Set base writing direction of this paragraph.
    
    - Parameter direction: base writing direction.
    */
    func baseWritingDirection(_ direction: AttrParagraphWritingDirection) -> AttrRangable {
        self.withAttr(.baseWritingDirection, value: direction)
    }

    /** Tightens inter-character spacing in attempt to fit lines wider than the available space if the line break mode is one of the truncation modes before starting to truncate.
    
    The maximum amount of tightening performed is determined by the system based on contexts such as font, line width, etc.
    
    - Parameter enable: whether allows default tightening.
    */
    func allowsDefaultTighteningForTruncation(_ enable: Bool) -> AttrRangable {
        self.withAttr(.allowsDefaultTighteningForTruncation, value: enable)
    }

    /** Set the default tab interval used for locations beyond the last element in tabStops
    
    - Parameter interval: default tab interval of tabStops.
    */
    func defaultTabInterval(_ interval: AttrNumber) -> AttrRangable {
        self.withAttr(.defaultTabInterval, value: interval.attributeFloat)
    }

    // **** Any One konws how to use NSTextTab could create an issue and show me how to use it...
    /** Add one text tabTab.
     https://stackoverflow.com/questions/32994463/decimal-point-alignment-in-ios-uilabel-during-countdown
    - Parameter textTab: new text tabStop.
    */
    func addTabStop(_ textTab: AttrTextTab) -> AttrExtendable {
        self.withAttr(.addTabStop, value: textTab)
    }

    // **** Any One konws how to use NSTextTab could create an issue and show me how to use it...
    /** Remove given textTab.
    
    - Parameter textTab: given text tabStop to remove.
    */
    func removeTabStop(_ textTab: AttrTextTab) -> AttrExtendable {
        self.withAttr(.removeTabStop, value: textTab)
    }

}

// MARK: Chains Combination.
public extension AttrExtendable {

    /** Append other attrSupported type data on current chain.
    
    - Parameter data: new AttrSupportedType data to be appended. Such as:
        - String
        - NSString
        - NSAttributedString
        - NSTextAttachment
    */
    func append(_ data: AttrSupportedType) -> AttrExtendable {
        let (originalResult, other) = self.splitFromHere(with: data)
        let left = NSMutableAttributedString(attributedString: originalResult)
        left.append(other.result())
        return AttrExtendable(raw: left)
    }

    /** Prepend other attrSupported type data on current chain.
    
    - Parameter data: new AttrSupportedType data to be prepended. Such as:
        - String
        - NSString
        - NSAttributedString
        - NSTextAttachment
    */
    func prepend(_ data: AttrSupportedType) -> AttrExtendable {
        let (original, other) = self.splitFromHere(with: data)
        let left = NSMutableAttributedString(attributedString: other.result())
        left.append(original)
        return AttrExtendable(raw: left)
    }

    /** Insert given chain into given location on current chain.
    
    - Parameter data: new AttrSupportedType data to be inserted. Such as:
        - String
        - NSString
        - NSAttributedString
        - NSTextAttachment
    - Parameter location: location to be inserted. value will be clamped to available interval.
    */
    func insert(_ data: AttrSupportedType, in location: Int) -> AttrExtendable {
        let (original, other) = self.splitFromHere(with: data)
        let current = NSMutableAttributedString(attributedString: original)
        let total = current.string.count
        let location = location.clamp(from: 0, into: total)
        if let mapped = current.string.nsIndexMapped(location) {
            current.insert(other.result(), at: mapped)
        }
        return AttrExtendable(raw: current)
    }

    #if os(iOS) || os(tvOS)
    /** Append image on current chain.
    
    - Parameter image: new image to be appended.
    - Parameter bounds: image bounds.
     */
    func append(image: AttrImage, bounds: CGRect) -> AttrExtendable {
        let attachment = NSTextAttachment()
        attachment.image = image
        attachment.bounds = bounds
        return self.append(attachment)
    }

    /** Prepend image on current chain.
    
    - Parameter image: new image to be prepended.
    - Parameter bounds: image bounds.
    */
    func prepend(image: AttrImage, bounds: CGRect) -> AttrExtendable {
        let attachment = NSTextAttachment()
        attachment.image = image
        attachment.bounds = bounds
        return self.prepend(attachment)
    }

    /** Insert image into given location on current chain.
    
    - Parameter image: new image to be inserted.
    - Parameter bounds: image bounds.
    - Parameter location: location to be inserted. value will be clamped to available interval.
    */
    func insert(image: AttrImage, bounds: CGRect, in location: Int) -> AttrExtendable {
        let attachment = NSTextAttachment()
        attachment.image = image
        attachment.bounds = bounds
        return self.insert(attachment, in: location)
    }
    #endif

    /** Append new chain on current chain.
    
    - Parameter chain: new chain to be appended.
    */
    func append(_ chain: AttrExtendable) -> AttrExtendable {
        self.append(chain.result())
    }

    /** Prepend new chain on current chain.
    
    - Parameter chain: new chain to be prepended.
    */
    func prepend(_ chain: AttrExtendable) -> AttrExtendable {
        self.prepend(chain.result())
    }

    /** Insert new chain into given location on current chain.
    
    - Parameter chain: new chain to be inserted.
    - Parameter location: location to be inserted. value will be clamped to available interval.
    */
    func insert(_ chain: AttrExtendable, in location: Int) -> AttrExtendable {
        self.insert(chain.result(), in: location)
    }

}

// MARK: Other Manipulation
public extension AttrExtendable {
    
    /** Preset attributes from specified style.
    
    - Parameter specified: given style of attributes.
    */
    func style(_ specified: AttrStyleExtendable) -> AttrRangable {
        self.withAttr(.style, value: AttrStyleData(specified.attributes()))
    }
    
    /** Preset attributes from specified style.
    
    - Parameter attributes: given style of [NSAttributedString.Key: Any].
    */
    func style(_ attributes: [NSAttributedString.Key: Any]) -> AttrRangable {
        self.withAttr(.style, value: AttrStyleData(attributes))
    }

    /** Erase some attributes.
    
    - Parameter attributes: OptionSet of attributes to be erased.
    */
    func erased(_ attributes: AttrErasedType) -> AttrRangable {
        self.withAttr(.erased, value: attributes)
    }

    /// Fix attributes.
    func fixed() -> AttrRangable {
        self.withAttr(.fixed, value: nil)
    }

    /// Set tag to specify the begining of attributes group setting.
    func fromHere() -> AttrExtendable {
        let result = AttrRangable(raw: self.raw, attributeItems: self.attributeItems)
        result.attributeItems = result.attributeItems.filter { $0.key != .fromHere }
        result.attributeItems.append(AttrItem(.fromHere, value: nil))
        return result
    }

}
