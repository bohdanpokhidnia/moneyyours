//
//  SelectInvoiceButtonStyle.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 16.06.2024.
//

import SwiftUI

struct SelectInvoiceButtonStyle: ButtonStyle {
    let emoji: String
    var emojiBackground: Color
    
    func makeBody(configuration: Configuration) -> some View {
        HStack(spacing: 16) {
            EmojiView(
                emoji: emoji,
                emojiBackground: emojiBackground
            )
            
            configuration.label
                .font(.system(size: 20, weight: .regular))
                .foregroundStyle(.primaryText)
                .multilineTextAlignment(.leading)
                .lineLimit(2)
                .minimumScaleFactor(0.5)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .contentShape(Rectangle())
        .opacity(configuration.isPressed ? 0.5 : 1.0)
    }
}
