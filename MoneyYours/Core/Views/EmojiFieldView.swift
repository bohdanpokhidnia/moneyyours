//
//  EmojiFieldView.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 18.12.2024.
//

import SwiftUI

struct EmojiFieldView: View {
    enum InputType {
        case textFiled(text: Binding<String>)
        case text(_ text: String)
    }
    
    let title: String
    let emoji: String
    var emojiBackground: Color = .rubberDuckyYellow
    let inputType: InputType
    var keyboardType: UIKeyboardType = .default
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        switch inputType {
        case .textFiled:
            content
                .onTapGesture {
                    isTextFieldFocused = true
                }
            
        case .text:
            content
        }
    }
    
    private var content: some View {
        VStack(spacing: 16) {
            HStack(spacing: 16) {
                EmojiView(
                    emoji: emoji,
                    emojiBackground: emojiBackground
                )
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(title)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(Color(hex: "#9A9A9A"))
                    
                    inputView(for: inputType)
                        .font(.system(size: 19, weight: .semibold))
                        .foregroundStyle(.primaryText)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(24)
        }
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
    
    @ViewBuilder
    private func inputView(for type: InputType) -> some View {
        switch inputType {
        case let .textFiled(text):
            TextField("", text: text)
                .keyboardType(keyboardType)
                .focused($isTextFieldFocused)
            
        case let .text(text):
            Text(text)
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    VStack(spacing: 16) {
        EmojiFieldView(
            title: "Input name",
            emoji: "📁",
            inputType: .textFiled(text: .constant("Name"))
        )
        
        EmojiFieldView(
            title: "Numbers",
            emoji: "📁",
            inputType: .text("123")
        )
    }
    .padding(.horizontal, 16)
}
