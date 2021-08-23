//
//  CombinationVC.swift
//  AttrKit-Demo-iOS
//
//  Created by 韩钢 on 2021/6/1.
//  Copyright © 2021 NickMeepo. All rights reserved.
//

import UIKit
import AttrKit

class CombinationVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    lazy var data: [NSAttributedString] = {
        var res = [NSAttributedString]()

        let origin = "123".attr.foreground(color: .red)

        res.append(
            origin.append("ABC") // Append a string.
                .systemFont(size: 21)
                .underline()
                .result()
        )
        
        res.append(
            origin.append("ABC".attr.foreground(color: .green)) // Append a chain.
                .systemFont(size: 21)
                .underline()
                .result()
        )
        
        res.append(
            origin.append("ABC".attr.foreground(color: .orange).result()) // Append a NSAttributedString.
                .systemFont(size: 21)
                .underline()
                .result()
        )
        
        let attachment = NSTextAttachment()
        attachment.image = UIImage(named: "tag")!
        attachment.bounds = CGRect(origin: .zero, size: CGSize(width: 20, height: 20))
        res.append(
            origin.append(attachment) // Append an attachment.
                .systemFont(size: 21)
                .underline()
                .result()
        )

        res.append(
            origin
                .append(
                    image: UIImage(named: "tag")!,
                    bounds: CGRect(origin: .zero, size: CGSize(width: 20, height: 20)))
                .systemFont(size: 21) // Append image as an attachment.
                .underline()
                .result()
        )
        
        res.append(
            origin.prepend("ABC") // Prepend a string.
                .systemFont(size: 21)
                .underline()
                .result()
        )
        
        res.append(
            origin.prepend("ABC".attr.foreground(color: .green)) // Prepend a chain.
                .systemFont(size: 21)
                .underline()
                .result()
        )
        
        res.append(
            origin.prepend("ABC".attr.foreground(color: .orange).result()) // Prepend a NSAttributedString.
                .systemFont(size: 21)
                .underline()
                .result()
        )
        
        res.append(
            origin.prepend(attachment) // Prepend an attachment.
                .systemFont(size: 21)
                .underline()
                .result()
        )

        res.append(
            origin
                .prepend(
                    image: UIImage(named: "tag")!,
                    bounds: CGRect(origin: .zero, size: CGSize(width: 20, height: 20)))
                .systemFont(size: 21) // Prepend image as an attachment.
                .underline()
                .result()
        )
        
        res.append(
            origin.insert("ABC", in: 2) // Insert a string in index 2.
                .systemFont(size: 21)
                .underline()
                .result()
        )
        
        res.append(
            origin.insert("ABC".attr.foreground(color: .green), in: 2) // Insert a chain in index 2.
                .systemFont(size: 21)
                .underline()
                .result()
        )
        
        res.append(
            origin.insert("ABC".attr.foreground(color: .orange).result(), in: 2) // Insert a NSAttributedString in index 2.
                .systemFont(size: 21)
                .underline()
                .result()
        )
        
        res.append(
            origin.insert(attachment, in: 2) // Insert an attachment in index 2.
                .systemFont(size: 21)
                .underline()
                .result()
        )

        res.append(
            origin
                .insert(
                    image: UIImage(named: "tag")!,
                    bounds: CGRect(origin: .zero, size: CGSize(width: 20, height: 20)),
                    in: 2)
                .systemFont(size: 21) // Insert image as an attachment in index 2.
                .underline()
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

extension CombinationVC: UITableViewDataSource, UITableViewDelegate {

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
