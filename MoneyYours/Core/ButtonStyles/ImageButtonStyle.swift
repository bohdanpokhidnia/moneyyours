//
//  ImageButtonStyle.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 22.06.2024.
//

import SwiftUI

struct ImageButtonStyle: ButtonStyle {
    let image: Image
    
    func makeBody(configuration: Configuration) -> some View {
        RoundedRectangle(cornerRadius: 16)
            .fill(.white)
            .overlay {
                HStack(spacing: 8) {
                    image
                        .resizable()
                        .frame(width: 20, height: 20)
                    
                    configuration.label
                        .font(.system(size: 16, weight: .semibold))
                }
            }
            .foregroundStyle(.tint)
            .frame(height: 52)
            .opacity(configuration.isPressed ? 0.5 : 1.0)
    }
}
