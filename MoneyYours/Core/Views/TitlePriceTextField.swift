//
//  TitlePriceTextField.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 01.02.2025.
//

import SwiftUI

struct TitlePriceTextField: View {
    let title: String
    let placeholder: String
    var text: Binding<String>
    
    var body: some View {
        PriceTextField(
            placeholder: placeholder,
            alignment: .leading,
            text: text
        )
        .textFieldStyle(HintGrayTextField(title: title))
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    @Previewable @State var text = "Text"
    
    TitlePriceTextField(
        title: "Title",
        placeholder: "Placeholder",
        text: $text
    )
}
