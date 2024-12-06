//
//  TextEmptyStateBackground.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 05.12.2024.
//

import SwiftUI

struct TextEmptyStateBackground: ViewModifier {
    let color: Color
    let state: TextEmptyStateView.State
    @Binding var isHiddenText: Bool
    
    func body(content: Content) -> some View {
        content
            .background {
                color
                    .ignoresSafeArea()
                
                if isHiddenText {
                    TextEmptyStateView(state: state)
                }
            }
    }
}

extension View {
    func textEmptyStateBackground(
        color: Color = .appBackground,
        isHiddenText: Binding<Bool>,
        state: TextEmptyStateView.State
    ) -> some View {
        modifier(
            TextEmptyStateBackground(
                color: color,
                state: state,
                isHiddenText: isHiddenText
            )
        )
    }
}
