## AttrKit

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

### Supports

1. Starting a chain from a String / NSString / NSAttributedString / NSTextAttachment / html string / rtf data. 

2. Setting font, text, paragraph attributes.

3. Setting range of attributes.

4. Setting regex pattern of attributes.

5. Combination of different chains.

6. Batch procedure on same ranges.

7. Reusable attribute style.

8. Transformation From and To HTML.

9. Transformation From and To RTF & RTFD.

10. Fixing and removing attributes in a chain.

11. Lower calling of addAttributes function.

12. Supporting text containing Emojii.

### Documentation
[Link](https://github.com/NickMeepo/AttrKit/blob/main/Documentation.md)

### Version
0.1.0

### Requirement
Swift 5
