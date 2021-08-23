//
//  AttrWritingDirection.swift
//  AttrKit
//
//  Created by HanGang on 2020/8/25.
//  Copyright © 2020 NickMeepo. All rights reserved.
//

import Foundation

/** Writing direction of attributed string.

**Enumerations**:
    - **LRE**
    - **RLE**
    - **LRO**
    - **RLO**
*/
public enum AttrWritingDirection: Int {

    /// leftToRightEmbedding
    ///
    /// NSWritingDirectionLeftToRight | NSTextWritingDirectionEmbedding
    case LRE = 0

    /// rightToLeftEmbedding
    ///
    /// NSWritingDirectionRightToLeft | NSTextWritingDirectionEmbedding
    case RLE = 1

    /// leftToRightOverride
    ///
    /// NSWritingDirectionLeftToRight | NSTextWritingDirectionOverride
    case LRO = 2

    /// rightToLeftOverride
    ///
    /// NSWritingDirectionRightToLeft | NSTextWritingDirectionOverride
    case RLO = 3

}
