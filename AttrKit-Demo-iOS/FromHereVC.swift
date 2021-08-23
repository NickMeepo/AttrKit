//
//  FromHereVC.swift
//  AttrKit-Demo-iOS
//
//  Created by 韩钢 on 2021/6/1.
//  Copyright © 2021 NickMeepo. All rights reserved.
//

import UIKit
import AttrKit

class FromHereVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    lazy var data: [NSAttributedString] = {
        var res = [NSAttributedString]()

        res.append(
            "AttrKit".attr
                .foreground(color: .red)
                .fromHere()
                .foreground(color: .green)
                .underline()
                .inRange(length: 3, to: "AttrKit".count) // add foreground, underline on "Kit"
                .systemFont(size: 21)
                .result()
        )
        
        res.append(
            "AttrKit".attr
                .foreground(color: .red)
                .fromHere()
                .foreground(color: .green)
                .underline()
                .inFirstOccur("Attr") // add foreground, underline on "Attr"
                .systemFont(size: 21)
                .result()
        )
        
        res.append(
            "AttrKit".attr
                .foreground(color: .red)
                .fromHere()
                .foreground(color: .green)
                .underline()
                .append(" is awesome.") // add foreground, underline on appending.
                .systemFont(size: 21)
                .result()
        )
        
        res.append(
            "AttrKit".attr
                .foreground(color: .red)
                .fromHere()
                .foreground(color: .green)
                .underline()
                .prepend("Awesome: ") // add foreground, underline on prepending.
                .systemFont(size: 21)
                .result()
        )
        
        res.append(
            "AttrKit".attr
                .foreground(color: .red)
                .fromHere()
                .foreground(color: .green)
                .underline()
                .inRange(from: 0, length: 4)
                .baselineOffset(6)
                .inOccur("t")
                .systemFont(size: 21)
                .result()
        )
        
        res.append(
            "AttrKit".attr
                .foreground(color: .red)
                .fromHere()
                .foreground(color: .green)
                .underline()
                .insert("[awesome]", in: 2) // add foreground, underline on insertion.
                .systemFont(size: 21)
                .result()
        )
        
        res.append(
            "AttrKit".attr
                .foreground(color: .red)
                .fromHere() // invalid fromHere
                .strikethrough()
                .fromHere() // valid fromHere matching .inFirstOccur("Attr")
                .foreground(color: .green)
                .underline()
                .inFirstOccur("Attr") // add foreground, underline on "Attr"
                .systemFont(size: 21)
                .result()
        )
        
        res.append(
            "AttrKit".attr
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
                .baselineOffset(-6)
                .append("###") // baseline setting on "###"
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

extension FromHereVC: UITableViewDataSource, UITableViewDelegate {

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
