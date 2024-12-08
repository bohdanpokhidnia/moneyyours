//
//  TextEmptyStateBackground.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 05.12.2024.
//

import SwiftUI

struct TextEmptyStateBackground: ViewModifier {
    let color: Color
    @Binding var state: TextEmptyStateView.State?
    
    func body(content: Content) -> some View {
        content
            .background {
                color
                    .ignoresSafeArea()
                
                if let state {
                    TextEmptyStateView(state: state)
                }
            }
    }
}

extension View {
    func textEmptyStateBackground(
        color: Color = .appBackground,
        state: Binding<TextEmptyStateView.State?>
    ) -> some View {
        modifier(
            TextEmptyStateBackground(
                color: color,
                state: state
            )
        )
    }
}
