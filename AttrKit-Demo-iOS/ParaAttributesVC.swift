//
//  ParaAttributesVC.swift
//  AttrKit-Demo-iOS
//
//  Created by HanGang on 2020/8/26.
//  Copyright © 2020 NickMeepo. All rights reserved.
//

import UIKit

class ParaAttributesVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    lazy var para: String = """
    Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.
    """

    lazy var data: [NSAttributedString] = {
        var res = [NSAttributedString]()
        let fontSize = 17

        res.append(
            "Initial Text with fontSize \(fontSize):\n".attr
                .boldSystemFont(size: fontSize)
                .append(self.para.attr.systemFont(size: fontSize))
                .result()
        )

        res.append(
            "Alignment center:\n".attr
                .boldSystemFont(size: fontSize)
                .fromHere()
                .systemFont(size: fontSize)
                .alignment(.center)
                .append(self.para)
                .result()
        )

        res.append(
            "Alignment right:\n".attr
                .boldSystemFont(size: fontSize)
                .fromHere()
                .systemFont(size: fontSize)
                .alignment(.right)
                .append(self.para)
                .result()
        )

        res.append(
            "Line break mode byCharWrapping:\n".attr
                .boldSystemFont(size: fontSize)
                .fromHere()
                .systemFont(size: fontSize)
                .lineBreakMode(.byCharWrapping)
                .append(self.para)
                .result()
        )

        res.append(
            "Line break mode byWordWrapping:\n".attr
                .boldSystemFont(size: fontSize)
                .fromHere()
                .systemFont(size: fontSize)
                .lineBreakMode(.byWordWrapping)
                .append(self.para)
                .result()
        )

        res.append(
            "hyphenation factor 0:\n".attr
                .boldSystemFont(size: fontSize)
                .fromHere()
                .systemFont(size: fontSize)
                .hyphenationFactor(0)
                .append(self.para)
                .result()
        )

        res.append(
            "hyphenation factor 1:\n".attr
                .boldSystemFont(size: fontSize)
                .fromHere()
                .systemFont(size: fontSize)
                .hyphenationFactor(1)
                .append(self.para)
                .result()
        )

        res.append(
            "Line spacing 15:\n".attr
                .boldSystemFont(size: fontSize)
                .fromHere()
                .systemFont(size: fontSize)
                .lineSpacing(15)
                .append(self.para)
                .result()
        )

        res.append(
            "Paragraph line spacing 15:\n".attr
                .boldSystemFont(size: fontSize)
                .fromHere()
                .systemFont(size: fontSize)
                .paragraphSpacing(15)
                .append(self.para)
                .result()
        )

        res.append(
            "Paragraph line spacing before 15:\n".attr
                .boldSystemFont(size: fontSize)
                .fromHere()
                .systemFont(size: fontSize)
                .paragraphSpacingBefore(15)
                .append(self.para)
                .result()
        )

        res.append(
            "First line head indent 15:\n".attr
                .boldSystemFont(size: fontSize)
                .fromHere()
                .systemFont(size: fontSize)
                .firstLineHeadIndent(15)
                .append(self.para)
                .result()
        )

        res.append(
            "Head indent 15:\n".attr
                .boldSystemFont(size: fontSize)
                .fromHere()
                .systemFont(size: fontSize)
                .headIndent(15)
                .append(self.para)
                .result()
        )

        res.append(
            "Tail indent -15:\n".attr
                .boldSystemFont(size: fontSize)
                .fromHere()
                .systemFont(size: fontSize)
                .tailIndent(-15)
                .append(self.para)
                .result()
        )

        res.append(
            "Minimum line height 20:\n".attr
                .boldSystemFont(size: fontSize)
                .fromHere()
                .systemFont(size: fontSize)
                .minimumLineHeight(20)
                .append(self.para)
                .result()
        )

        res.append(
            "Line height multiple 1.5:\n".attr
                .boldSystemFont(size: fontSize)
                .fromHere()
                .systemFont(size: fontSize)
                .lineHeightMultiple(1.5)
                .append(self.para)
                .result()
        )

        res.append(
            "Paragraph base writing direction from right to left:\n".attr
                .boldSystemFont(size: fontSize)
                .fromHere()
                .systemFont(size: fontSize)
                .baseWritingDirection(.rightToLeft)
                .lineBreakMode(.byWordWrapping)
                .append(self.para)
                .result()
        )

        res.append(
            "Paragraph base writing direction from right to left:\n".attr
                .boldSystemFont(size: fontSize)
                .fromHere()
                .systemFont(size: fontSize)
                .baseWritingDirection(.rightToLeft)
                .append(self.para)
                .result()
        )

        res.append(
            "Allow default tightening for truncation tail:\n".attr
                .boldSystemFont(size: fontSize)
                .fromHere()
                .systemFont(size: fontSize)
                .allowsDefaultTighteningForTruncation(true)
                .lineBreakMode(.byTruncatingTail)
                .append(self.para)
                .result()
        )

        res.append(
            "Not Allow default tightening for truncation tail:\n".attr
                .boldSystemFont(size: fontSize)
                .fromHere()
                .systemFont(size: fontSize)
                .allowsDefaultTighteningForTruncation(false)
                .lineBreakMode(.byTruncatingTail)
                .append(self.para)
                .result()
        )

        res.append(
            para.attr
                .boldSystemFont(size: 17)
                .firstLineHeadIndent(15)
                .foreground(color: .darkGray)
                .headIndent(15)
                .lineSpacing(8)
                .result()
        )
            
        res.append(
            "a text".attr
                .append(" and center text ".attr.alignment(.center))
                .lineSpacing(5)
                .result()
        )
        
        res.append(
            "a text".attr
                .append("\nand center paragraph".attr.alignment(.center))
                .lineSpacing(5)
                .result()
        )
        
        return res
    }()

}

extension ParaAttributesVC: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ParaCell") as! ParaCell
        cell.tev.attributedText = self.data[indexPath.row]
        cell.accessoryType = .detailButton
        return cell
    }

    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let vc = AttributeDescVC.instance(self.data[indexPath.row])
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

class ParaCell: UITableViewCell {

    @IBOutlet weak var tev: UITextView!

}
