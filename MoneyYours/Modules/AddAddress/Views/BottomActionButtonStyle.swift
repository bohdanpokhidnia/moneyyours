//
//  BottomActionButtonStyle.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 15.06.2024.
//

import SwiftUI
import ComposableArchitecture

struct BottomActionButtonStyle: ButtonStyle {
    @Dependency(\.appColor) private var appColor
    @Environment(\.isEnabled) private var isEnabled
    
    func makeBody(configuration: Configuration) -> some View {
        RoundedRectangle(cornerRadius: 14)
            .fill(isEnabled ? appColor.tint : .pastelGrey)
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
