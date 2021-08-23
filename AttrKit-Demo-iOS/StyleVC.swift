//
//  StyleVC.swift
//  AttrKit-Demo-iOS
//
//  Created by HanGang on 2020/8/25.
//  Copyright © 2020 NickMeepo. All rights reserved.
//

import UIKit
import AttrKit

class StyleVC: UIViewController {

    @IBOutlet weak var tev: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()


        tev.isEditable = false
        tev.isSelectable = true
        
        tev.linkTextAttributes =  AttrStyle
            .foreground(color: .red)
            .underline()
            .obliqueness(0.25)
            .attributes()
        
        let preset = AttrStyle
            .systemFont(size: 21, traits: [.traitBold, .traitItalic])
            .kern(3)
            .foreground(color: .brown)
        
        let preset2 = AttrStyle
            .systemFont(size: 16)
            .foreground(color: .cyan)
            .obliqueness(-0.25)
        
        tev.attributedText = "This is a string with Link.".attr
            .link(url: URL(string: "https://www.github.com"))
            // or equally:
            //.link(url: "https://www.github.com")
            .inOccur("Link")
            .append("\nText with style.")
            .style(preset)
            .fromHere()
            .style(preset2)
            .append("\n Another text with style2.")
            .append("\nPlain text....")
            .lineSpacing(5)
            .result()
    }

}

extension StyleVC: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange) -> Bool {
        return true
    }
}
