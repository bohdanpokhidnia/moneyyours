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
            .fill(isEnabled ? enabledFillColor(configuration: configuration) : fillColor.opacity(0.5))
            .overlay {
                configuration.label
                    .foregroundStyle(enabledLabelColor(configuration: configuration))
                    .font(.system(size: 16, weight: .bold))
                    .padding(.vertical, 12)
            }
            .frame(maxHeight: 56)
    }
    
    private func enabledFillColor(configuration: Configuration) -> Color {
        fillColor.opacity(configuration.isPressed ? 0.5 : 1.0)
    }
    
    private func enabledLabelColor(configuration: Configuration) -> Color {
        Color.white.opacity(configuration.isPressed ? 0.5 : 1.0)
    }
}
