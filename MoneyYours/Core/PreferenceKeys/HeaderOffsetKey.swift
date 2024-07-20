//
//  HeaderOffsetKey.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 19.07.2024.
//

import SwiftUI

struct HeaderOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
