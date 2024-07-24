//
//  MonthInvoiceRow.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 23.06.2024.
//

import SwiftUI

struct MonthInvoiceRow: View {
    @State var text: String = ""
    @State var text1: String = ""
    let invoice: Invoice
    
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
                    text: $text
                )
                
                priceView(
                    price: invoice.amount.formatted(.ukrainianHryvnia),
                    title: "Amount",
                    placeholder: "Now",
                    prompt: "Value",
                    text: $text1
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

#Preview("InvoiceItemRow", traits: .sizeThatFitsLayout) {
    ZStack {
        MonthInvoiceRow(invoice: .mock)
    }
    .background(.black)
}
