## Documentation of AttrKit

A chain to generate NSAttributedString.

### Example:
```swift
let attrString = "Welcom to use AttrKit.".attr
    .foreground(color: .darkGray)
    .systemFont(size: 17)
    .foreground(color: .red)
    .inOccur("AttrKit")
    .result()
```

### Start a Chain
Basically, you can start an attr chain from 4 types data: String/NSString/NSAttributedString/NSTextAttachment:

```swift 
// from a String
aString.attr 

// from a NSString
aNSString.attr 

// from a NSAttribtuedString
aNSAttributedString.attr 

// from a NSTextAttachment
aNSTextAttachment.attr 
```

Additionally, custom class AttrHtml / AttrRtf / AttrRtfd can also start a chain and we will introduce these types later. You can let any class follow the protocol ***AttrSupportedType*** to start a chain as well.

```swift
// from a AttrHtml
AttrHtml(html: aHTMLString)?.attr 

// from a AttrRtf
AttrRtf(data)?.attr

// from a AttrRtfd
AttrRtfd(data)?.attr
```

After starting a chain, we can set font, text, paragraph attributes on text. We call functions setting font, text, paragraph attributes as *attribute functions*. 

### Font Attributes
Use following functions to set font attributes:

```swift
_ = "AttrKit".attr

    // set given font.
    .font(aFont) 

    // set given font with traits. 
    .font(aFont, traits: [.traitBold, .traitItalic]) 

    // set given font from name and size.
    .font(name: "Courier", size: 17) 

    // set given font from fontDescriptor and size.
    .font(descriptor: aFontDescriptor, size: 17) 

    // set systemFont with size.
    .systemFont(size: 17) 

    // set systemFont with size and traits.
    .systemFont(size: 17, traits: [.traitBold, .traitItalic]) 

    // set bold systemFont with size.
    .boldSystemFont(size: 17) 

    // set italic systemFont with size.
    .italicSystemFont(size: 17) 

    // set monospaced systemFont with size. 
    .monospacedSystemFont(size: 17) 

    // set monospaced digit systemFont with size. 
    .monospacedDigitSystemFont(size: 17) 

    // set font with preferredStyle.
    .preferredFont(style: .headline) 
```

If you have set a given font in a chain, or previous NSAttributedString data has set a specified font before, then you can use following functions to set a new font from the previous setting font(***Notice***: If no font set before, then the following function will have no effect.):

```swift
_ = "AttrKit".attr

    .italicSystemFont(size: 17) // setting a specified font before...

    // add traits on previous font.
    .withFontTraits(added: .traitBold) 

    // remove given font trait from previous font.
    .withFontTraits(removed: .traitItalic) 

    // add point size of previois font.
    .withFontSize(changed: 4) 

    // minus point size of previois font.
    .withFontSize(changed: -4) 
```

### Text Attributes
Use following functions to set text attributes:

```swift
_ = "AttrKit".attr

    // setting text color.
    .foreground(color: .red) 

    // setting text background color.
    .background(color: .gray) 

    // setting text underline.
    .underline() 

    // setting text underline with style and color.
    .underline(style: .single, color: .red) 

    // setting text strikethrough.
    .strikethrough() 

    // setting text strikethrough with style and color.
    .strikethrough(style: .single, color: .red) 

    // setting text stroke with color and width.
    .stroke(color: .green, width: 1) 

    // setting text kerning.
    .kern(0.5) 

    // setting text expansion.
    .expansion(0.25) 

    // setting text obliqueness.
    .obliqueness(0.25) 

    // settinte text vertical offset.
    .baseline(-0.25) 

    // setting text shadow with x-y offset, radius and color.
    .shadow(x: 2, y: -2, radius: 2, color: .yellow) 

    // setting text ligature style.
    .ligature(style: .default) 

    // setting text writing direction: LRE, RLE, LRO, RLO.
    .writing(from: .leftToRightEmbedding) 

    // setting glyph form style of text. horizontal or vertical.
    .glyphForm(style: .horizontal) 

    // setting textEffect as letterpress style.
    .letterpressStyle() 

    // setting text link to given url.
    .link(url: aURL) 

    // or setting text link to given string which is url convertable.
    .link(url: aURLString) 
```

### Paragraph Attributes
Use following functions to set paragraph attributes.

```swift
_ = "AttrKit".attr
    // setting alignment of the paragraph.
    .alignment(.center) 

    // setting lineBreakMode of the paragraph.
    .lineBreakMode(.byTruncatingTail) 

    // setting line spacing of paragraph.
    .lineSpacing(5) 

    // setting spacing after the end of the paragraph.
    .paragraphSpacing(5) 
    
    // setting spacing between the paragraph’s top and the beginning of its text content.
    .paragraphSpacingBefore(5) 

    // setting indentation of the first line of the paragraph.
    .firstLineHeadIndent(2) 

    // setting indentation of the paragraph’s lines other than the first.
    .headIndent(2) 

    // setting trailing indentation of the paragraph.
    .tailIndent(2) 

    // setting paragraph’s minimum line height.
    .minimumLineHeight(10) 

    // setting paragraph’s maximum line height.
    .maximumLineHeight(20) 

    // setting paragraph’s threshold for hyphenation in [0,1].
    .hyphenationFactor(0.5) 

    // setting base writing direction for the paragraph.
    .baseWritingDirection(.rightToLeft) 

    // setting whether the system tightens intercharacter spacing before truncating text.
    .allowsDefaultTighteningForTruncation(true) 

    // setting documentwide default tab interval.
    .defaultTabInterval(10)
```

### Range Setting
In the following example, we get a attributed string with textColor red on whole range of the text:

```swift
let attrString = "AttrKit".attr
    .foreground(color: .red) // foreground color setting on "AttrKit"
    .result()
```

AttrKit also supports setting attributes on given range. The following example shows textColor red set on `Attr` instead of on whole range. 

```swift
let attrString2 = "AttrKit".attr
    .foreground(color: .red)
    .inRange(from: 0, length: 4) // foreground color setting on "Attr"
```

There are several functions to indicate ranges where given attributes are set. We call them *range functions*. Each *range functions* must follow the attributs functions. None continuous *range functions* exist. A range function following one attribute function indicate appointed ranges where this attribute is set. Batch of attributes setting by one *range functions* are also supported, which will be introduced in the **fromHere** section.

```swift
"AttrKit".attr

    // in NSRange from location 0 to location 7. range of "AttrKit".
    .systemFont(size: 21)
    .inRange(from: 0, to: 7) 

    // in NSRange from location 0 with length 4. range of "Attr".
    .foreground(color: .red)
    .inRange(from: 0, length: 4)  

    // in NSRange to location 7 with length 3. range of "Kit".
    .baseline(5)
    .inRange(length: 3, to: 7) 

    // in set of NSRanges where substring "t" occurs.
    .underline()
    .inOccur("t") 

    // in NSRange where substring "t" occurs firstly.
    .strikethrough()
    .inFirstOccur("t") 

    // in set of NSRanges where substring satisfying pattern "[a-z]".
    .withFontTraits(added: [.traitBold, .traitItalic])
    .inMatch("[a-z]") 

    // in NSRange where substring satisfying pattern "[a-z]" firstly.
    .withFontSize(changed: -5)
    .inFirstMatch("[a-z]") 
    
    .result()
```

### Combination of Chains
AttrKit supports combination of different chains in the way of appending、prepending and inserting:

```swift
let chain = "123".attr.foreground(color: .red)
let attachment = NSTextAttachment()
attachment.image = UIImage(named: "tag")!
attachment.bounds = CGRect(origin: .zero, size: CGSize(width: 20, height: 20))

// Append a string.
_ = chain.append("ABC") 
    .underline()
    .result()

// Append a chain.
_ = chain.append("ABC".attr.foreground(color: .green)) 
    .underline()
    .result()

// Append a NSAttributedString.
_ = chain.append("ABC".attr.foreground(color: .orange).result()) 
    .underline()
    .result()

// Append an attachment.
_ = chain.append(attachment) 
    .underline()
    .result()

// Append image as an attachment.
_ = chain.append(image: UIImage(named: "tag")!, bounds: CGRect(origin: .zero, size: CGSize(width: 20, height: 20))) 
    .underline()
    .result()

// Prepend a string.
_ = chain.prepend("ABC") 
    .underline()
    .result()

// Prepend a chain.
_ = chain.prepend("ABC".attr.foreground(color: .green)) 
    .underline()
    .result()

// Prepend a NSAttributedString.
_ = chain.prepend("ABC".attr.foreground(color: .orange).result()) 
    .underline()
    .result()

// Prepend an attachment.
_ = chain.prepend(attachment) 
    .underline()
    .result()

// Prepend image as an attachment.
_ = chain.prepend(image: UIImage(named: "tag")!, bounds: CGRect(origin: .zero, size: CGSize(width: 20, height: 20))) 
    .underline()
    .result()

// Insert a string in given index.
_ = chain.insert("ABC", in: 2) 
    .underline()
    .result()

// Insert a chain in given index.
_ = chain.insert("ABC".attr.foreground(color: .green), in: 2) 
    .underline()
    .result()

// Insert a NSAttributedString in given index.
_ = chain.insert("ABC".attr.foreground(color: .orange, in: 2).result()) 
    .underline()
    .result()

// Insert an attachment in given index.
_ = chain.insert(attachment, in: 2) 
    .underline()
    .result()

// Insert image as an attachment in given index.
_ = chain.insert(image: UIImage(named: "tag")!, bounds: CGRect(origin: .zero, size: CGSize(width: 20, height: 20)), in: 2) 
    .underline()
    .result()
```

Functions like append, prepend, insert are called as *combination functions.*

### Usage of fromHere
When using *range function* to add multiple attributes on same ranges, you could write:

```swift
_ = "AttrKit".attr
    .foreground(color: .red)
    .foreground(color: .green)
    .inFirstOccur("Attr")
    .underline()
    .inFirstOccur("Attr")
    .systemFont(size: 21)
    .result()
```

Here we can use *fromHere function* to add multiple attributes on same ranges from one *range function*, as followed:

```swift
_ = "AttrKit".attr
    .foreground(color: .red)
    .fromHere()
    .foreground(color: .green)
    .underline()
    .inFirstOccur("Attr") // foreground, underline adding on range of "Attr"
    .systemFont(size: 21)
    .result()
```

*fromHere function* could also match *combination functions*, before using *fromHere function*, we could write:

```swift
_ = "AttrKit".attr
    .foreground(color: .red)
    .append(" is awesome.".attr.foreground(color: .green).underline())
    .systemFont(size: 21)
    .result()
```

After using *fromHere function*, we could write:

```swift
_ = "AttrKit".attr
    .foreground(color: .red)
    .fromHere()
    .foreground(color: .green)
    .underline()
    .append(" is awesome.") // appending string with foreground, underline attributes.
    .systemFont(size: 21)
    .result()
```

*Notice* : *range functions* and *combination functions* will try to match nearest *fromHere function*. Every matching will invalidate previous unmatched *fromHere functions*.

```swift
_ = "AttrKit".attr
    .foreground(color: .red)

    .fromHere() // invalid fromHere
    .strikethrough()

    .fromHere() // valid fromHere matching .inFirstOccur("Attr")
    .foreground(color: .green)
    .underline()
    .append(" is awesome") // foreground, underline setting on " is awesome"

    .fromHere() // invalid fromHere
    .systemFont(size: 30)

    .fromHere() // valid fromHere matching .append("###")
    .baseline(-6)
    .append("###") // baseline setting on "###"

    .result()
```

### Usage of AttrStyle
In some cases we want to get a dictionary of type **[NSAttributedString.Key: Any]**. AttrKit use **AttyStyle chain** to generate this dictionary. **AttyStyle** link each chain node using *attribute functions*. **AttyStyle chain** doesn`t support *combination functions* and *range functions*. Function attributes() finalizes the chain and return the final dictionary.

The following example of setting UITextView`s linkTextAttributes shows the usage of AttrStyle:

```swift
textView.linkTextAttributes =  AttrStyle
    .foreground(color: .red)
    .underline()
    .obliqueness(0.25)
    .attributes() // return the data of type [NSAttributedString.Key: Any]
```

**AttrStyle** can also be added in the attr chain with the *style function*, such as followed:

```swift
let preset = AttrStyle
    .systemFont(size: 21, traits: [.traitBold, .traitItalic])
    .kern(3)
    .foreground(color: .brown)

let preset2 = AttrStyle
    .systemFont(size: 16)
    .foreground(color: .cyan)
    .obliqueness(-0.25)

textView.attributedText = "This is a string with Link.".attr
    .link(url: URL(string: "https://www.github.com"))
    .inOccur("Link")
    .append("\nText with style.")
    .style(preset) // preset style added on text above all(some maybe except from the text of link).

    .fromHere()
    .style(preset2)
    .append("\n Another text with style2.") // preset2 style added on text of this line.

    .append("\nPlain text....")

    .lineSpacing(5)
    .result()
```

Notice that *style function* can also work with *fromHere function* and *range functions*.

### Transformation From and To HTML
Sometimes annoying backend engineers may want you to transform html string to NSAttributedString and show it. AttrKit meets this demand by usage of **AttrHTML**:

```swift
let htmlString = """
<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.01//EN\" \"http://www.w3.org/TR/html4/strict.dtd\">\n<html>\n<head>\n<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">\n<meta http-equiv=\"Content-Style-Type\" content=\"text/css\">\n<title></title>\n<meta name=\"Generator\" content=\"Cocoa HTML Writer\">\n<style type=\"text/css\">\np.p1 {margin: 0.0px 0.0px 0.0px 0.0px; color: #ff0000}\nspan.s1 {font-family: \'Helvetica\'; font-weight: normal; font-style: normal; font-size: 12.00px}\n</style>\n</head>\n<body>\n<p class=\"p1\"><span class=\"s1\">AttrKit</span></p>\n</body>\n</html>\n
"""

// by protocol function of AttrSupportedType.
let attributedString = AttrHTML(htmlString)?.rawAttributedString 

// by attr chain and adding attributes.
let attributedString2 = AttrHTML(htmlString)?.attr 
    .systemFont(size: 21)
    .result()
```

You can also get html string from a chain with *html function*:

```swift
let htmlString = "AttrKit".attr
    .foreground(color: .red)
    .systemFont(size: 21)
    .html()
```

*Notice:* Transformation from and to HTML are not lossless. Some attributes will be lost, such as kern, expansion, strikethrough and underline color, and so on. 

*Notice:* You should also notice that font size unit in NSAttributedString is pt, but in transformed html string the font size unit is px with the same value.

### Transformation From and To RTF & RTFD
AttrKit supports transformation from NSAttributedString to RTF & RTFD:

```swift
let path = NSHomeDirectory() + "/Documents/aaa.rtf"
let attachment = NSTextAttachment()
attachment.image = UIImage(named: "tag")!
attachment.bounds = CGRect(origin: .zero, size: CGSize(width: 20, height: 20))
let rtfData = "aaabbbccc".attr
    .foreground(color: .green)
    .background(color: .cyan)
    .systemFont(size: 17)
    .underline()
    .inOccur("aaa")
    .append(attachment)
    .rtf(documentAttributes: [
        .backgroundColor: UIColor.red,
        .readOnly: true
    ])

let rtfdData = "aaabbbccc".attr
    .foreground(color: .green)
    .background(color: .cyan)
    .systemFont(size: 17)
    .underline()
    .inOccur("aaa")
    .append(attachment)
    .rtfd(documentAttributes: [
        .backgroundColor: UIColor.red,
        .readOnly: true
    ])
```

and transformation from RTF & RTFD to NSAttributedString by usage of  & **AttrRTFD**:

```swift
let attr1 = AttrRTF(rtfData).attr.result()

let attr2 = AttrRTFD(rtfdData).attr.result()
```

### Other Functions
1. fix function

fixAttributes method of NSMutableAttributedString are supported in the chain by *fixed function*, which can work with *from function* and *range functions*:

```swift
_ = "AttrKit".attr
    .fixed()
    .result() // fixAttributes of text "AttrKit"

_ = "AttrKit".attr
    .fixed()
    .inRange(from: 0, length: 4)
    .result() // fixAttributes of text "Attr"
```

2. erased function

removeAttribute method of NSMutableAttributedString are supported in the chain by *erased function*, which can work with *from function* and *range functions*:

```swift
_ = "AttrKit with underline erased".attr
    .foreground(color: .red)
    .fromHere()
    .foreground(color: .green)
    .underline()
    .inRange(length: 3, to: "AttrKit".count) // add foreground, underline on "Kit"
    .systemFont(size: 21)
    .erased(.underline) // remove underline attribute on "Kit"
    .result()

_ = "AttrKit with underline erased".attr
    .foreground(color: .red)
    .fromHere()
    .foreground(color: .green)
    .underline()
    .inRange(length: 3, to: "AttrKit".count) // add foreground, underline on "Kit"
    .systemFont(size: 21)
    .erased(.underline) // remove underline attribute on "Kit"
    .inRange(from: 1, to: "AttrKit".count) // remove underline attribute on "t"
    .result()
```

### Other Tips
1. the Meaning of Index 

In NSAttributedString and AttrKit, the index means index of slot between each character, not the index of the character. 

For example of string "ABC", it`s slot view is "⌴A⌴B⌴C⌴". A range from location 0 and location 2 points to text between the first splot "⌴" previous "A" and the third slot "⌴" previous "C". That is "AB", and the length of this range is the length of "AB", which is 2.

2. Performance Tips

Frequently performing addAttributes of NSMutableAttributedString is quiet inefficient. AttrKit tries to reduce the amount of calling addAttributes function. To accomplish this goal, you should try you best to add attributes on same ranges, instead of using interlaced range functions. Following examples will show this tip.

```swift
// bad performance example
_ = "atext".attr
    .systemFont(size: 17) // on whole range
    .background(color: .red)
    .inRange(from: 0, length: 1) // on range of "a"
    .foreground(color: .brown) // on whole range
    .underline()
    .inRange(from: 0, length: 1) // on range of "a"
    .strikethrough() // on whole range
    .kern(0.5)
    .inRange(from: 0, length: 1) // on range of "a"
    .result()

// good performance example
_ = "atext".attr
    
    // on whole range
    .systemFont(size: 17) 
    .foreground(color: .brown)
    .strikethrough()

    // on range of "a"
    .background(color: .red)
    .underline()
    .kern(0.5)
    .inRange(from: 0, length: 1) 
    
    .result()
```

3. Emojii Supported
We have tested range functions with text containing emojii. In same language such as Chinese, index of emojii text like "😊你好" may have different meaning. Difference between text encoding of String and NSString results in it. And AttrKit have fixed this problem.

### Existence Flaws

AttrKit is a framework which is inspired by SnapKit. Some flaws still exists and we list as follows. 

1. Coutinus text with sub paragraph style will be covered.

```swift
// In this example, alignment of "456" will be lost.
"123".attr
    .append("456".attr.alignment(.center))
    .lineSpacing(5)
    .result()

// In this example, alignment of "456" will be maintained.
"123".attr
    .append("\n456".attr.alignment(.center))
    .lineSpacing(5)
    .result()
```

2. Lack of testing NSTextTab
NSTextTab is never used before. The effect of NSTextTab is still testing.

### Version
0.1.0

### Requirement

- iOS 11.0+ / Mac OS X 10.15+ / tvOS 11.0+

- Xcode 10.0+

- Swift 5.0+