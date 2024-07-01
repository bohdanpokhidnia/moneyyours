//
//  InvoiceItemRow.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 23.06.2024.
//

import SwiftUI

struct InvoiceItemRow: View {
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
                VStack(alignment: .leading, spacing: 8) {
                    Text(invoice.price.formatted(.ukrainianHryvnia))
                        .font(.price)
                        .foregroundStyle(.primaryText)
                    
                    Text("Price at 1")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(.starDust)
                    
                    TextField(
                        "Past",
                        text: $text
                    )
                    .keyboardType(.numberPad)
                    .textFieldStyle(HintGrayTextField(prompt: "Value"))
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(invoice.amount.formatted(.ukrainianHryvnia))
                        .font(.price)
                        .foregroundStyle(.primaryText)
                    
                    Text("Amount")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(.starDust)
                    
                    TextField(
                        "Current",
                        text: $text1
                    )
                    .keyboardType(.numberPad)
                    .textFieldStyle(HintGrayTextField(prompt: "Value"))
                }
            }
            .padding([.horizontal, .bottom], 16)
        }
        .background(.invoiceBackground)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

#Preview("InvoiceItemRow", traits: .sizeThatFitsLayout) {
    ZStack {
        InvoiceItemRow(invoice: .mock)
    }
    .background(.black)
}
