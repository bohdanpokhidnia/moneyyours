//
//  BottomActionButtonStyle.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 15.06.2024.
//

import SwiftUI
import ComposableArchitecture

struct BottomActionButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled
    var fillColor: Color
    
    func makeBody(configuration: Configuration) -> some View {
        RoundedRectangle(cornerRadius: 14)
            .fill(fillColor)
            .padding(.horizontal, 16)
            .overlay {
                configuration.label
                    .foregroundStyle(.white)
                    .font(.system(size: 16, weight: .bold))
                    .padding(.vertical, 12)
            }
            .frame(maxHeight: 56)
    }
}
