//
//  AttributeDescVC.swift
//  AttrKit-Demo-iOS
//
//  Created by HanGang on 2020/8/25.
//  Copyright © 2020 NickMeepo. All rights reserved.
//

import UIKit
import AttrKit

class AttributeDescVC: UIViewController {

    var attributedString: NSAttributedString? {
        didSet {
            if isViewLoaded {
                updateView()
            }
        }
    }

    @IBOutlet weak var tev: UITextView!
    @IBOutlet weak var htmlTev: UITextView!
    @IBOutlet weak var htmlConvertedLab: UILabel!

    func updateView() {
        self.tev.text = attributedString?.description
        self.htmlTev.text = attributedString?.attr.html()
        self.htmlConvertedLab.attributedText = AttrHtml(self.htmlTev.text)?.attr.result()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }

    static func instance(_ attributedString: NSAttributedString) -> AttributeDescVC {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AttributeDescVC") as! AttributeDescVC
        vc.attributedString = attributedString
        return vc
    }

}
