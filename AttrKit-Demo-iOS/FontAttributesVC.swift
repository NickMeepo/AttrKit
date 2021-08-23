//
//  FontAttributesVC.swift
//  AttrKit-Demo-iOS
//
//  Created by HanGang on 2020/8/11.
//  Copyright © 2020 NickMeepo. All rights reserved.
//

import UIKit
import AttrKit

class FontAttributesVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    lazy var data: [NSAttributedString] = {
        var res = [NSAttributedString]()
                
        res.append(
            "Plain attributed text.".attr
                .result()
        )

        res.append(
            "Custom font using systemFont with trait condensed".attr
                .font(.systemFont(ofSize: 17), traits: [.traitCondensed])
                .result()
        )

        res.append(
            "Custom font with name 'Courier' and size 17".attr
                .font(name: "Courier", size: 17)
                .result()
        )

        let courier = UIFont(name: "Courier", size: 17)!
        res.append(
            "Custom font with given font descriptor and size 17".attr
                .font(descriptor: courier.fontDescriptor, size: 17)
                .result()
        )

        res.append(
            "System font".attr
                .systemFont(size: 17)
                .result()
        )

        res.append(
            "System font with trait bold and italic".attr
                .systemFont(size: 17, traits: [.traitBold, .traitItalic])
                .result()
        )

        res.append(
            "Bold system font".attr
                .boldSystemFont(size: 17)
                .result()
        )

        res.append(
            "Italic System Font".attr
                .italicSystemFont(size: 17)
                .result()
        )

        if #available(iOS 13.0, *) {
            res.append(
                "Monospaced system font".attr
                    .monospacedSystemFont(size: 17)
                    .result()
            )
        }

        res.append(
            "Monospaced digit system font".attr
                .monospacedDigitSystemFont(size: 17)
                .result()
        )

        res.append(
            "Preferred font headline".attr
                .preferredFont(style: .headline)
                .result()
        )

        res.append(
            "Preferred font subheadline".attr
                .preferredFont(style: .subheadline)
                .result()
        )

        res.append(
            "Preferred font footnote".attr
                .preferredFont(style: .footnote)
                .result()
        )

        res.append(
            "Preferred font callout".attr
                .preferredFont(style: .callout)
                .result()
        )

        res.append(
            "Preferred font caption1".attr
                .preferredFont(style: .caption1)
                .result()
        )

        res.append(
            "Preferred font caption2".attr
                .preferredFont(style: .caption2)
                .result()
        )

        res.append(
            "Preferred font body".attr
                .preferredFont(style: .body)
                .result()
        )

        if #available(iOS 11.0, *) {
            res.append(
                "Preferred font largeTitle".attr
                .preferredFont(style: .largeTitle)
                .result()
            )
        }

        res.append(
            "Preferred font title1".attr
                .preferredFont(style: .title1)
                .result()
        )

        res.append(
            "Preferred font title2".attr
                .preferredFont(style: .title2)
                .result()
        )

        res.append(
            "Preferred font title3".attr
                .preferredFont(style: .title3)
                .result()
        )

        res.append(
            "Using system font, then add trait itaic and bold".attr
                .systemFont(size: 17)
                .withFontTraits(added: [.traitItalic, .traitBold])
                /* or equally:
                 .addFontTraits(.traitItalic)
                 .addFontTraits(.traitBold)
                 */
                .result()
        )

        res.append(
            "using system font 17 with trait bold and italic, then remove trait italic and bold".attr
                .systemFont(size: 17, traits: [.traitBold, .traitItalic])
                .withFontTraits(removed: [.traitBold, .traitItalic])
                /* or equally:
                 .removeFontTraits(.traitBold)
                 .removeFontTraits(.traitItalic)
                 */
                .result()
        )

        let changing = 4
        res.append(
            "Using system font with trait bold and italic, then add \(changing) point font size".attr
                .systemFont(size: 17, traits: [.traitBold, .traitItalic])
                .withFontSize(changed: changing)
                .result()
        )

        res.append(
            "using system font with trait bold and italic, then minus \(changing) point font size".attr
                .systemFont(size: 17, traits: [.traitBold, .traitItalic])
                .withFontSize(changed: -changing)
                .result()
        )

        /************************ Warning Tests ************************/
        res.append(
            "⚠️ Adding traits will have no effect, before any font is set.".attr
                .withFontTraits(added: .traitBold)
                .systemFont(size: 17)
                .result()
        )

        res.append(
            "⚠️ Removing traits will have no effect, before any font is set.".attr
                .withFontTraits(removed: .traitBold)
                .boldSystemFont(size: 17)
                .result()
        )

        res.append(
            "⚠️ Changing font size will have no effect, before any font is set.".attr
                .withFontSize(changed: 2)
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

extension FontAttributesVC: UITableViewDataSource, UITableViewDelegate {

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
