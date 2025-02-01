//
//  PriceTextField.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 29.01.2025.
//

import SwiftUI

struct PriceTextField: View {
    @Binding var text: String
    
    var body: some View {
        TextField("", text: $text)
            .multilineTextAlignment(.center)
            .onChange(of: text) { _, newValue in
                text = newValue.formatted(.priceInput)
            }
    }
}

#Preview {
    @Previewable @State var text: String = "0.00"
    
    PriceTextField(text: $text)
}
