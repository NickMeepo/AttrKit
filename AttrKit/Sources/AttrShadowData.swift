//
//  AttrShadowData.swift
//  AttrKit
//
//  Created by HanGang on 2020/7/9.
//  Copyright © 2020 NickMeepo. All rights reserved.
//

import Foundation
import CoreGraphics

internal struct AttrShadowData {

    let color: AttrColor

    let radius: AttrNumber

    let offset: CGSize

    init?(color: AttrColor?, offset: CGSize, radius: AttrNumber) {
        guard let color = color else { return nil }
        self.color = color
        self.radius = radius
        self.offset = offset
    }

}

extension AttrShadowData {

    var shadow: AttrShadow {
        let result = AttrShadow()
        result.shadowOffset = offset
        result.shadowColor = color
        result.shadowBlurRadius = radius.attributeFloat
        return result
    }

}
