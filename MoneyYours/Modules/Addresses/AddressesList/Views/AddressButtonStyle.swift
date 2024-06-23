//
//  AddressButtonStyle.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 12.06.2024.
//

import SwiftUI

struct AddressButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack(spacing: 18) {
            EmojiView(
                emoji: "📂",
                emojiBackground: .rubberDuckyYellow
            )
            
            configuration.label
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(.foreground)
                .lineLimit(2)
                .minimumScaleFactor(0.3)
            
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 20)
        .background {
            Color(configuration.isPressed ? .systemGray4 : .actionButtonBackground)
                .clipShape(RoundedRectangle(cornerRadius: 14))
        }
    }
}
