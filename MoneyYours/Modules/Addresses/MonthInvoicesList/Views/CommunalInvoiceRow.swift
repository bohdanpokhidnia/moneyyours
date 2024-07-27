//
//  CommunalInvoiceRow.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 23.06.2024.
//

import SwiftUI

struct CommunalInvoiceRow: View {
    let invoice: CommunalInvoice
    @Binding var past: String
    @Binding var now: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(spacing: 16) {
                EmojiView(
                    emoji: invoice.type.emoji,
                    emojiBackground: invoice.type.emojiBackground
                )
                
                Text(invoice.type.name)
                    .font(.system(size: 26, weight: .medium))
            }
            .padding([.top, .leading], 16)
            
            HStack(spacing: 16) {
                priceView(
                    price: invoice.price.formatted(.ukrainianHryvnia),
                    title: "Price at 1",
                    placeholder: "Past",
                    prompt: "Value",
                    text: $past
                )
                
                priceView(
                    price: invoice.amount.formatted(.ukrainianHryvnia),
                    title: "Amount",
                    placeholder: "Now",
                    prompt: "Value",
                    text: $now
                )
            }
            .padding([.horizontal, .bottom], 16)
        }
        .background(.invoiceBackground)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
    
    func priceView(
        price: String,
        title: String,
        placeholder: String,
        prompt: String,
        text: Binding<String>
    ) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(.starDust)
            
            Text(price)
                .font(.price)
                .foregroundStyle(.primaryText)
            
            TextField(
                placeholder,
                text: text
            )
            .keyboardType(.numberPad)
            .textFieldStyle(HintGrayTextField(prompt: prompt))
        }
    }
}

#Preview("InvoiceRow", traits: .sizeThatFitsLayout) {
    ZStack {
        CommunalInvoiceRow(
            invoice: .mock,
            past: .constant("1"),
            now: .constant("2")
        )
    }
    .background(.black)
}
