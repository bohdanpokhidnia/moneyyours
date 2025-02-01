//
//  SelectPriceRow.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 01.02.2025.
//

import SwiftUI

struct SelectPriceRow: View {
    let emoji: String
    let title: String
    
    init(emoji: String, title: String) {
        self.emoji = emoji
        self.title = title
    }
    
    var body: some View {
        HStack(spacing: 16) {
            Text("\(emoji) \(title)")
                .foregroundStyle(.primaryText)
                .font(.headline)
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    @Previewable let price: Price = .fixed(value: .zero)
    
    SelectPriceRow(
        emoji: price.emoji,
        title: price.name
    )
}
