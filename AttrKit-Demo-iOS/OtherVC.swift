//
//  OtherVC.swift
//  AttrKit-Demo-iOS
//
//  Created by 韩钢 on 2021/6/4.
//  Copyright © 2021 NickMeepo. All rights reserved.
//

import UIKit
import AttrKit

class OtherVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    lazy var data: [NSAttributedString] = {
        var res = [NSAttributedString]()
        
        res.append(
            "ColorSetting".attr
                .style(AttrStyle.foreground(color: .green).foreground(color: nil))
                .foreground(color: nil)
                .systemFont(size: 21)
                .result()
        )
        
        res.append(
            "AttrKit with underline erased".attr
                .foreground(color: .red)
                .fromHere()
                .foreground(color: .green)
                .underline()
                .inRange(length: 3, to: "AttrKit".count) // add foreground, underline on "Kit"
                .systemFont(size: 21)
                .erased(.underline)
                .inOccur("t")
                .result()
        )
        
        res.append(
            "Line 1 with text...\nLine 2 with text...\nfixed...".attr
                .lineSpacing(10)
                .inOccur("Line")
                .systemFont(size: 21)
                .fixed()
                .result()
        )
        
        res.append(
            "Line 1 with text...\nLine 2 with text...\nnonfixed...".attr
                .foreground(color: .darkGray)
                .fromHere()
                .foreground(color: .red)
                .lineSpacing(25)
//                .defaultTabInterval(20)
                .alignment(.center)
                .inOccur("Line")
                .systemFont(size: 21)
//                .fromHere()
//                .defaultTabInterval(20)
//                .alignment(.right)
//                .lineSpacing(10)
//                .inOccur("with")
                .result()
        )
        
        return res
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 70
    }
}

extension OtherVC: UITableViewDataSource, UITableViewDelegate {

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
