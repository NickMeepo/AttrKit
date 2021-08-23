//
//  AttrStyleItem.swift
//  AttrKit
//
//  Created by 韩钢 on 2021/6/3.
//  Copyright © 2021 NickMeepo. All rights reserved.
//

import Foundation

internal struct AttrStyleItem {

    let key: AttrKey

    let value: AttrGeneralData?

    init(_ key: AttrKey, value: AttrGeneralData?) {
        self.key = key
        self.value = value
    }

}
