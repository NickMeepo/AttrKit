//
//  AttrItem.swift
//  AttrKit
//
//  Created by HanGang on 2020/7/9.
//  Copyright © 2020 NickMeepo. All rights reserved.
//

import Foundation

internal struct AttrItem {

    let key: AttrKey

    let value: AttrGeneralData?

    let range: AttrRange

    init(_ key: AttrKey, value: AttrGeneralData?, range: AttrRange = .full) {
        self.key = key
        self.value = value
        self.range = range
    }

}
