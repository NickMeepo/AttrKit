//
//  ViewController.swift
//  AttrKit-Demo-macOS
//
//  Created by 韩钢 on 2021/7/15.
//  Copyright © 2021 NickMeepo. All rights reserved.
//

import Cocoa
import AttrKit

class ViewController: NSViewController {

    
    @IBOutlet var tev: NSTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //"\t43:21"
        // https://www.it1352.com/927043.html
        tev.textStorage?.setAttributedString(
            "43:21.22".attr
                .systemFont(size: 16)
                .underline()
//                .superScript(2)
//                .cursor(image: AttrImage(), foregroundColorHint: .red, backgroundColorHint: .green, hotSpot: .init(x: 1, y: 1))
//                .markedClauseSegment(2)
//                .toolTip("Aha")
                .paragraphSpacing(20)
                .defaultTabInterval(20)
                .addTabStop(.init(textAlignment: .right, location: 40, options: [.columnTerminators: CharacterSet(charactersIn: "\t:.")]))
                .result())
        
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

