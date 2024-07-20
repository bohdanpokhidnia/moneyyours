//
//  ViewRectKey.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 19.07.2024.
//

import SwiftUI

struct ViewRectKey: PreferenceKey {
    static var defaultValue: CGRect = .zero

    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}
