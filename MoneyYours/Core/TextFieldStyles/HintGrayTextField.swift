//
//  HintGrayTextField.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 23.06.2024.
//

import SwiftUI

struct HintGrayTextField: TextFieldStyle {
    let prompt: String
    
    func _body(configuration: TextField<_Label>) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(prompt)
                .font(.system(size: 12, weight: .semibold))
                .foregroundStyle(.mountainMist)
            
            configuration.body
                .font(.system(size: 16, weight: .semibold))
        }
        .padding(.horizontal, 18)
        .padding(.vertical, 16)
        .background(.whiteSmoke)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
