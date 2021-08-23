//
//  AttrLineData.swift
//  AttrKit
//
//  Created by HanGang on 2020/7/9.
//  Copyright © 2020 NickMeepo. All rights reserved.
//

import Foundation

internal struct AttrLineData {

    let color: AttrColor

    let style: AttrLineStyle

    init?(color: AttrColor?, style: AttrLineStyle) {
        guard let color = color else { return nil }
        self.color = color
        self.style = style
    }

}
