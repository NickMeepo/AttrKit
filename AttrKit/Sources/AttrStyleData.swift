//
//  AttrStyleData.swift
//  AttrKit
//
//  Created by 韩钢 on 2021/6/3.
//  Copyright © 2021 NickMeepo. All rights reserved.
//

import Foundation

internal struct AttrStyleData {

    let dictionary: [NSAttributedString.Key: Any]

    init(_ dictionary: [NSAttributedString.Key: Any]) {
        self.dictionary = dictionary
    }

}
