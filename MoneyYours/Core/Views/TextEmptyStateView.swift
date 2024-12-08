//
//  TextEmptyStateView.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 05.12.2024.
//

import SwiftUI

struct TextEmptyStateView: View {
    struct State: Equatable {
        let title: String
        let description: String
    }
    
    let state: State
    
    var body: some View {
        VStack(spacing: 16) {
            Text(state.title)
                .font(.system(size: 22, weight: .bold))
                .foregroundStyle(.textEmpyState)
            
            Text(state.description)
                .font(.system(size: 15, weight: .regular))
                .multilineTextAlignment(.center)
                .foregroundStyle(.textEmpyState)
        }
    }
}

#Preview {
    TextEmptyStateView(
        state: TextEmptyStateView.State(
            title: "You’re offline",
            description: "There’s no internet connection right now. There’s no internet connection right now."
        )
    )
}
