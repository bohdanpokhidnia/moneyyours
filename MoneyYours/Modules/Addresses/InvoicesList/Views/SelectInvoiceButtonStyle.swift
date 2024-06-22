//
//  SelectInvoiceButtonStyle.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 16.06.2024.
//

import SwiftUI

struct SelectInvoiceButtonStyle: ButtonStyle {
    let emoji: String
    var emojiBackground: Color = .clear
    
    func makeBody(configuration: Configuration) -> some View {
        HStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(emojiBackground.gradient)
                    .frame(width: 48, height: 48)
                
                Text(emoji)
                    .font(.system(size: 20))
            }
            
            configuration.label
                .font(.system(size: 20, weight: .regular))
                .foregroundStyle(.appTitle)
                .multilineTextAlignment(.leading)
                .lineLimit(2)
                .minimumScaleFactor(0.5)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .contentShape(Rectangle())
        .opacity(configuration.isPressed ? 0.5 : 1.0)
    }
}
