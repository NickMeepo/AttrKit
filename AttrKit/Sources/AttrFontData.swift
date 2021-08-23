//
//  AttrFontData.swift
//  AttrKit
//
//  Created by HanGang on 2020/7/13.
//  Copyright © 2020 NickMeepo. All rights reserved.
//

import Foundation

internal struct AttrFontData {

    let font: AttrFont

    let traits: AttrFontTraits?

    init?(font: AttrFont?, traits: AttrFontTraits?) {
        guard let font = font else { return nil }
        self.font = font
        self.traits = traits
    }

}

extension AttrFontData {

    func fontWithTraits() -> AttrFont {
        self.fontWithTraits(insertOrRemove: true)
    }

    func fontWithoutTraits() -> AttrFont {
        self.fontWithTraits(insertOrRemove: false)
    }

    private func fontWithTraits(insertOrRemove added: Bool) -> AttrFont {
        if let traits = self.traits, !traits.isEmpty {
            var traitsAll = self.font.fontDescriptor.symbolicTraits
            if added {
                traitsAll.insert(traits)
                return self.font.changeTraits(traitsAll)
            } else {
                traitsAll.remove(traits)
                return self.font.changeTraits(traitsAll)
            }
        }
        return self.font
    }

}
