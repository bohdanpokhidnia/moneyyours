//
//  TextEmptyStateView.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 05.12.2024.
//

import SwiftUI

struct TextEmptyStateView: View {
    let title: String
    let description: String
    
    var body: some View {
        VStack(spacing: 16) {
            Text(title)
                .font(.system(size: 22, weight: .bold))
                .foregroundStyle(.textEmpyState)
            
            Text(description)
                .font(.system(size: 15, weight: .regular))
                .multilineTextAlignment(.center)
                .foregroundStyle(.textEmpyState)
        }
    }
}

#Preview {
    TextEmptyStateView(
        title: "You’re offline",
        description: "There’s no internet connection right now. There’s no internet connection right now."
    )
}
