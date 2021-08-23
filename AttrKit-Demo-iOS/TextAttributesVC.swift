//
//  TextAttributesVC.swift
//  AttrKit-Demo-iOS
//
//  Created by HanGang on 2020/8/11.
//  Copyright © 2020 NickMeepo. All rights reserved.
//

import UIKit
import AttrKit

class TextAttributesVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    lazy var data: [NSAttributedString] = {
        var res = [NSAttributedString]()

        res.append(
            "Text with foreground color red".attr
                .foreground(color: .red)
                .systemFont(size: 17)
                .result()
        )

        res.append(
            "Text with background color red".attr
                .background(color: .red)
                .systemFont(size: 17)
                .result()
        )

        res.append(
            "Text with background color red and foreground color blue".attr
                .background(color: .red)
                .foreground(color: .blue)
                .systemFont(size: 17)
                .result()
        )

        res.append(
            "Text with default underline".attr
                .underline()
                .systemFont(size: 17)
                .result()
        )

        res.append(
            "Text with underline with [.patternDot, .double] style and color magenta".attr
                .underline(style: [.patternDot, .double], color: .magenta)
                .systemFont(size: 17)
                .result()
        )

        res.append(
            "Text with default strikethrough".attr
                .strikethrough()
                .systemFont(size: 17)
                .result()
        )

        res.append(
            "Text with strikethrough with [.patternDot, .double] style and color magenta".attr
                .strikethrough(style: [.patternDot, .double], color: .magenta)
                .systemFont(size: 17)
                .result()
        )

        res.append(
            "Text with strikethrough and underline".attr
                .strikethrough(style: [.patternDot, .double], color: .magenta)
                .underline(style: [.single], color: .red)
                .result()
        )

        let strokeWidthBase = 3
        res.append(
            "Text with stroke color red and stroke width \(strokeWidthBase), and forground color green will have no effect.".attr
                .stroke(color: .red, width: strokeWidthBase)
                .foreground(color: .green)
                .systemFont(size: 17)
                .result()
        )

        res.append(
            "Text with stroke color red and stroke width -\(strokeWidthBase), and forground color green will be filled in.".attr
                .stroke(color: .red, width: -strokeWidthBase)
                .foreground(color: .green)
                .systemFont(size: 17)
                .result()
        )

        let kernBase = 2
        res.append(
            "Text with kern \(kernBase)".attr
                .kern(kernBase)
                .systemFont(size: 17)
                .result()
        )

        res.append(
            "Text with kern 0".attr
                .kern(0)
                .systemFont(size: 17)
                .result()
        )

        res.append(
            "Text with kern -\(kernBase)".attr
                .kern(-kernBase)
                .systemFont(size: 17)
                .result()
        )

        let expansionBase = 0.5
        res.append(
            "Text with expansion \(expansionBase)".attr
                .expansion(expansionBase)
                .systemFont(size: 17)
                .result()
        )

        res.append(
            "Text with expansion 0".attr
                .expansion(0)
                .systemFont(size: 17)
                .result()
        )

        res.append(
            "Text with expansion -\(expansionBase)".attr
                .expansion(-expansionBase)
                .systemFont(size: 17)
                .result()
        )

        let obliquenessBase = 0.25
        res.append(
            "Text with obliqueness \(obliquenessBase)".attr
                .obliqueness(obliquenessBase)
                .systemFont(size: 17)
                .result()
        )

        res.append(
            "Text with obliqueness 0".attr
                .obliqueness(0)
                .systemFont(size: 17)
                .result()
        )

        res.append(
            "Text with obliqueness -\(obliquenessBase)".attr
                .obliqueness(-obliquenessBase)
                .systemFont(size: 17)
                .result()
        )

        let baselineBase = 5
        res.append(
            "Text with baseline \(baselineBase)".attr
                .baselineOffset(baselineBase)
                .append(" (#and here is normal baseline offset).")
                .systemFont(size: 17)
                .result()
        )

        res.append(
            "Text with baseline -\(baselineBase)".attr
                .baselineOffset(-baselineBase)
                .append(" (#and here is normal baseline offset).")
                .systemFont(size: 17)
                .result()
        )

        res.append(
            "Text with shadow offset(3, 3), radius(1), color red".attr
                .shadow(x: 3, y: 3, radius: 1, color: .red)
                .systemFont(size: 17)
                .result()
        )

        res.append(
            "Text with shadow offset(3, 3), radius(-1), color red".attr
                .shadow(x: 3, y: 3, radius: -1, color: .red)
                .systemFont(size: 17)
                .result()
        )

        res.append(
            "Text with shadow offset(-3, -3), radius(-1), color red".attr
                .shadow(offset: CGSize(width: -3, height: -3), radius: -1, color: .red)
                .systemFont(size: 17)
                .result()
        )

        res.append(
            "Text with font 'futura' and set ligature enabled: 'fifl'".attr
                .ligature(style: .default)
                .font(name: "futura", size: 17)
                .result()
        )

        res.append(
            "Text with font 'futura' and set ligature disabled: 'fifl'".attr
                .ligature(style: .none)
                .font(name: "futura", size: 17)
                .result()
        )

        res.append(
            "Text with direction from left to right embedding".attr
                .writing(from: .LRE)
                .systemFont(size: 17)
                .result()
        )

        res.append(
            "Text with direction from right to left embedding".attr
                .writing(from: .RLE)
                .systemFont(size: 17)
                .result()
        )

        res.append(
            "Text with direction from left to right override".attr
                .writing(from: .LRO)
                .systemFont(size: 17)
                .result()
        )

        res.append(
            "Text with direction from right to left override".attr
                .writing(from: .RLO)
                .systemFont(size: 17)
                .result()
        )

        res.append(
            "Text with glyph form horizontal, nothing happend on iOS indeed".attr
                .glyphForm(style: .horizontal)
                .systemFont(size: 17)
                .result()
        )

        res.append(
            "Text with letterpressing style".attr
                .letterpressStyle()
                .systemFont(size: 17)
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

extension TextAttributesVC: UITableViewDataSource, UITableViewDelegate {

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
