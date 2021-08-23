//
//  AttrSpellingState.swift
//  AttrKit
//
//  Created by HanGang on 2020/8/25.
//  Copyright © 2020 NickMeepo. All rights reserved.
//

#if os(macOS)
/// The spelling state of the text.
public enum AttrSpellingState: Int {
    
    /// no grammar or spelling errors
    case normal = 0

    /// exists spelling errors
    case spelling = 1

    /// exists grammar errors
    case grammar = 2
    
}

#endif
