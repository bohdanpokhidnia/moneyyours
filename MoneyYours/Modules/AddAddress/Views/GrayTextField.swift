//
//  GrayTextField.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 12.06.2024.
//

import SwiftUI

struct GrayTextField: TextFieldStyle {
    func _body(configuration: TextField<_Label>) -> some View {
        configuration.body
            .padding(.horizontal, 16)
            .padding(.vertical, 19)
            .font(.system(size: 16, weight: .semibold))
            .background(.whiteSmoke)
            .clipShape(RoundedRectangle(cornerRadius: 14))
    }
}
