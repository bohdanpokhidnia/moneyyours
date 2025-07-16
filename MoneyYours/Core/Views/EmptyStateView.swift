//
//  EmptyStateView.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 05.12.2024.
//

import SwiftUI

struct EmptyStateView: View {
    struct State: Equatable {
        var image: Image?
        var imageColor: Color = .blue.opacity(0.7)
        let title: String
        let description: String
    }
    
    let state: State
    
    var body: some View {
        VStack(spacing: 24) {
            if let image = state.image {
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .foregroundColor(state.imageColor)
            }
            
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
    EmptyStateView(
        state: EmptyStateView.State(
            title: "You’re offline",
            description: "There’s no internet connection right now. There’s no internet connection right now."
        )
    )
}
