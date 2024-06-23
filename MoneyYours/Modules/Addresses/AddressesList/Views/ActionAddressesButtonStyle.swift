//
//  ActionAddressesButtonStyle.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 12.06.2024.
//

import SwiftUI

struct ActionAddressesButtonStyle: ButtonStyle {
    let title: String
    var emoji: String
    var emojiBackground: Color = .clear
    
    func makeBody(configuration: Configuration) -> some View {
        RoundedRectangle(cornerRadius: 14)
            .fill(configuration.isPressed ? Color(.systemGray4) : .actionButtonBackground)
            .frame(minWidth: 210, maxHeight: 80)
            .overlay(alignment: .leading) {
                HStack(spacing: 16) {
                    EmojiView(
                        emoji: emoji,
                        emojiBackground: emojiBackground
                    )
                    
                    Text(title)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(.foreground)
                        .lineLimit(1)
                        .minimumScaleFactor(0.2)
                }
                .padding(.leading, 16)
            }
    }
}
