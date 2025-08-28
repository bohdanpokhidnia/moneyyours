//
//  PriceTextField.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 29.01.2025.
//

import SwiftUI

struct PriceTextField: View {
    var placeholder: String
    var alignment: TextAlignment
    @Binding var text: String
    
    var body: some View {
        TextField(placeholder, text: $text)
            .multilineTextAlignment(alignment)
            .onChange(of: text) { oldValue, newValue in
                if newValue.count == 3, oldValue == "0.00" {
                    text = "0"
                } else {
                    text = newValue.formatted(.priceInput)
                }
            }
    }
}

#Preview {
    @Previewable @State var text: String = "0.00"
    
    PriceTextField(
        placeholder: "",
        alignment: .center,
        text: $text
    )
}
