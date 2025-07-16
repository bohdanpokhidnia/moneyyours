//
//  GradientHeaderView.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 15.06.2024.
//

import SwiftUI

struct GradientHeaderView: View {
    let configuration: GradientHeaderConfiguration
    
    init(configuration: GradientHeaderConfiguration) {
        self.configuration = configuration
    }
    
    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: configuration.colors),
            startPoint: UnitPoint(x: 0.11966469444160704, y: 8.33727533122719e-8),
            endPoint: UnitPoint(x: 0.8125000346174127, y: 0.9733925237930536)
        )
    }
}

#Preview("GradientHeaderView", traits: .sizeThatFitsLayout) {
    GradientHeaderView(configuration: .addresses)
        .frame(height: 147)
}
