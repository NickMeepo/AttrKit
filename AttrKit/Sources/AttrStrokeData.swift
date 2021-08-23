//
//  AttrStrokeData.swift
//  AttrKit
//
//  Created by HanGang on 2020/7/9.
//  Copyright © 2020 NickMeepo. All rights reserved.
//

import Foundation

internal struct AttrStrokeData {

    let color: AttrColor

    let width: AttrNumber

    init?(color: AttrColor?, width: AttrNumber) {
        guard let color = color else { return nil }
        self.color = color
        self.width = width
    }

}
