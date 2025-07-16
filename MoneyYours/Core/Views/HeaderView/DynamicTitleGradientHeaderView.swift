//
//  DynamicTitleGradientHeaderView.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 29.06.2025.
//

import SwiftUI

struct DynamicTitleGradientHeaderView: View {
    let title: String
    var titleColor: Color = .white
    var titleAlignment: Alignment = .bottomLeading
    let configuration: GradientHeaderConfiguration
    
    @State private var navigationBarHeight: CGFloat = .zero
    
    var body: some View {
        TitleGradientHeaderView(
            title: title,
            titleColor: titleColor,
            titleAlignment: titleAlignment,
            configuration: configuration
        )
        .frame(height: safeArea.top + navigationBarHeight * 2)
        .background {
            NavigationBarHeightReader(navigationBarHeight: $navigationBarHeight)
        }
    }
}
