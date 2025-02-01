//
//  TitleTextField.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 01.02.2025.
//

import SwiftUI

struct TitleTextField: View {
    let title: String
    let placeholder: String
    var text: Binding<String>
    
    var body: some View {
        TextField(
            placeholder,
            text: text
        )
        .textFieldStyle(HintGrayTextField(prompt: title))
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    @Previewable @State var text = "Text"
    
    TitleTextField(
        title: "Title",
        placeholder: "Placeholder",
        text: $text
    )
}
