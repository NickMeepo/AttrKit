//
//  AttrAnyLink.swift
//  AttrKit
//
//  Created by HanGang on 2020/8/25.
//  Copyright © 2020 NickMeepo. All rights reserved.
//

import Foundation

internal struct AttrAnyLink {

    let url: AttrURL

    init?(url: AttrURL?) {
        guard let url = url else { return nil }
        self.url = url
    }

}
