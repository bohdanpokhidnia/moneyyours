//
//  TitleGradientHeaderView.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 16.06.2024.
//

import SwiftUI

struct TitleGradientHeaderView: View {
    let title: String
    var titleAlignment: Alignment = .bottomLeading
    var colors: [Color]? = nil
    var presetColors: GradientHeaderView.PresetColors? = nil
    
    var body: some View {
        gradientView()
            .overlay(alignment: titleAlignment) {
                titleText
            }
    }
}

private extension TitleGradientHeaderView {
    @ViewBuilder
    func gradientView() -> some View {
        if let colors {
            GradientHeaderView(colors: colors)
        } else if let presetColors {
            GradientHeaderView(presetColors: presetColors)
        } else {
            EmptyView()
        }
    }
    
    var titleText: some View {
        Text(title)
            .font(.screenTitle)
            .foregroundStyle(.white)
            .lineLimit(1)
            .padding([.horizontal, .bottom], 16)
    }
}

#Preview {
    TitleGradientHeaderView(
        title: Address.mock.name,
        presetColors: .addresses
    )
}
