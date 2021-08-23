//
//  RangableVC.swift
//  AttrKit-Demo-iOS
//
//  Created by 韩钢 on 2021/5/26.
//  Copyright © 2021 NickMeepo. All rights reserved.
//

import UIKit
import AttrKit

class RangableVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    lazy var data: [NSAttributedString] = {
        var res = [NSAttributedString]()

        let str1 = "123"
        for length in 0...(str1.count + 1) {
            res.append(
                str1.attr
                    .foreground(color: .lightGray)
                    .foreground(color: .orange)
                    .inRange(from: 0, length: length)
                    .result()
            )
        }

        let str2 = "abc"
        for end in 0...(str2.count + 1) {
            res.append(
                str2.attr
                    .foreground(color: .lightGray)
                    .foreground(color: .brown)
                    .inRange(from: 0, to: end)
                    .result()
            )
        }

        let str3 = "ABC"
        for length in 0...(str3.count + 1) {
            res.append(
                str3.attr
                    .foreground(color: .lightGray)
                    .foreground(color: .brown)
                    .inRange(length: length, to: str3.count)
                    .result()
            )
        }
        
        let this = "AttrKit".attr
            .systemFont(size: 21)
            .inRange(from: 0, to: 7) // in NSRange from location 0 to location 7. range of "AttrKit".

            .foreground(color: .red)
            .inRange(from: 0, length: 4)  // in NSRange from location 0 with length 4. range of "Attr".

            .baselineOffset(5)
            .inRange(length: 3, to: 7) // in NSRange to location 7 with length 3. range of "Kit".

            .underline()
            .inOccur("t") // in set of NSRanges where substring "t" occurs.
            
            .strikethrough()
            .inFirstOccur("t") // in NSRange where substring "t" occurs firstly.
            
            .withFontTraits(added: [.traitBold, .traitItalic])
            .inMatch("[a-z]") // in set of NSRanges where substring satisfying pattern "[a-z]".
            
            .withFontSize(changed: -5)
            .inFirstMatch("[a-z]") // in NSRange where substring satisfying pattern "[a-z]" firstly.
            
            .result()
        
        res.append(this)

        return res
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 70
    }
}

extension RangableVC: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        cell.textLabel?.attributedText = self.data[indexPath.row]
        cell.textLabel?.numberOfLines = 0
        cell.accessoryType = .detailButton
        return cell
    }

    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let vc = AttributeDescVC.instance(self.data[indexPath.row])
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
