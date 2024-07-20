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
    let configuration: GradientHeaderConfiguration

    var body: some View {
        GradientHeaderView(configuration: configuration)
            .overlay(alignment: titleAlignment) {
                titleText
            }
    }
}

// MARK: - Views

private extension TitleGradientHeaderView {
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
        configuration: GradientHeaderConfiguration(presetColors: .addresses)
    )
}
