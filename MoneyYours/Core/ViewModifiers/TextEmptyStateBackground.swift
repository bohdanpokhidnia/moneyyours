//
//  TextEmptyStateBackground.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 05.12.2024.
//

import SwiftUI

struct TextEmptyStateBackground: ViewModifier {
    let color: Color
    let title: String
    let description: String
    @Binding var isHiddenText: Bool
    
    func body(content: Content) -> some View {
        content
            .background {
                color
                    .ignoresSafeArea()
                
                if isHiddenText {
                    TextEmptyStateView(
                        title: title,
                        description: description
                    )
                }
            }
    }
}

extension View {
    func textEmptyStateBackground(
        color: Color = .appBackground,
        isHiddenText: Binding<Bool>,
        title: String,
        description: String
    ) -> some View {
        modifier(
            TextEmptyStateBackground(
                color: color,
                title: title,
                description: description,
                isHiddenText: isHiddenText
            )
        )
    }
}
