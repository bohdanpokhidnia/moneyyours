//
//  EmojiRowButtonStyle.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 12.06.2024.
//

import SwiftUI

struct EmojiRowButtonStyle: ButtonStyle {
    let emoji: String
    let emojiBackground: Color
    
    func makeBody(configuration: Configuration) -> some View {
        HStack(spacing: 18) {
            EmojiView(
                emoji: emoji,
                emojiBackground: emojiBackground
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
