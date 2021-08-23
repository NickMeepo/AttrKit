//
//  HomeVC.swift
//  AttrKit-Demo-iOS
//
//  Created by HanGang on 2020/8/10.
//  Copyright © 2020 NickMeepo. All rights reserved.
//

import UIKit

typealias HomePageIndices = ([(title: String, identifier: String)])

class HomeVC: UIViewController {

    lazy var data: HomePageIndices = [
        ("Font Attributes", "FontAttributesVC"),
        ("Text Attributes", "TextAttributesVC"),
        ("Paragraph Attributes", "ParaAttributesVC"),
        ("Range Setting", "RangableVC"),
        ("Chains` Combination", "CombinationVC"),
        ("Usage of fromHere", "FromHereVC"),
        ("Usage of AttrStyle", "StyleVC"),
        ("Other Functions", "OtherVC")
    ]

}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        cell.textLabel?.text = self.data[indexPath.row].title
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: self.data[indexPath.row].identifier)
        vc.title = self.data[indexPath.row].title
        self.navigationController?.pushViewController(vc, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
