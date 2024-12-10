//
//  IdentifiedArray.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 09.12.2024.
//

import ComposableArchitecture
import SwiftUI

extension IdentifiedArrayOf {
    var isBindingEmpty: Binding<Bool> {
        Binding(
            get: {
                isEmpty
            }
        )
    }
}
