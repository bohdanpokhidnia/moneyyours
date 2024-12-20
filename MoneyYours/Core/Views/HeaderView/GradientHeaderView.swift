//
//  GradientHeaderView.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 15.06.2024.
//

import SwiftUI

struct GradientHeaderView: View {
    let colors: [Color]
    
    init(configuration: GradientHeaderConfiguration) {
        if let colors = configuration.colors {
            self.colors = colors
        } else if let presetColors = configuration.presetColors {
            self.colors = presetColors.colors
        } else {
            self.colors = []
        }
    }
    
    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: colors),
            startPoint: UnitPoint(x: 0.11966469444160704, y: 8.33727533122719e-8),
            endPoint: UnitPoint(x: 0.8125000346174127, y: 0.9733925237930536)
        )
    }
}

extension GradientHeaderView {
    enum PresetColors {
        case addresses
        
        var colors: [Color] {
            switch self {
            case .addresses: [.cerulean, .richElectricBlue, .frenchBlue]
            }
        }
    }
}

#Preview("GradientHeaderView", traits: .sizeThatFitsLayout) {
    GradientHeaderView(
        configuration: GradientHeaderConfiguration(presetColors: .addresses)
    )
    .frame(height: 147)
}
