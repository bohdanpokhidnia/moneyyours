//
//  SummaryRow.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 30.06.2025.
//

import SwiftUI

protocol EmojiAvailable {
    var name: String { get }
    var emoji: String { get }
    var color: Color { get }
}

extension EmojiAvailable {
    var title: String {
        [name, emoji].joined(separator: " ")
    }
}

struct SummaryRow: View {
    var item: EmojiAvailable
    var title: String
    var price: Double
    
    var body: some View {
        HStack(spacing: 16) {
            EmojiView(
                emoji: item.emoji,
                emojiBackground: item.color
            )
            
            Text(title)
                .fontWeight(.semibold)
            
            Spacer()
            
            Text(price.formatted(.ua))
                .fontWeight(.medium)
        }
    }
}

#Preview {
    SummaryRow(
        item: CommunalInvoiceType.water,
        title: "Water",
        price: 100
    )
}
