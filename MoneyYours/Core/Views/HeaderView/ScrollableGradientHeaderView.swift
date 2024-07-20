//
//  ScrollableGradientHeaderView.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 19.07.2024.
//

import SwiftUI

struct ScrollableGradientHeaderView<ContentView: View>: View {
    var title: String
    var configuration: GradientHeaderConfiguration
    var headerHeight: CGFloat
    var minVisibleHeight: CGFloat
    @ViewBuilder var content: () -> ContentView
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                GeometryReader { (proxy) in
                    let minY = proxy.frame(in: .global).minY
                    
                    Color.clear
                        .preference(key: HeaderOffsetKey.self, value: minY)
                }
                .frame(height: headerHeight)
                .zIndex(1)
                
                content()
            }
        }
        .contentMargins(.top, headerHeight, for: .scrollIndicators)
        .overlayPreferenceValue(HeaderOffsetKey.self, alignment: .top) { (offsetY) in
            let isScrollingUp = offsetY > 0
            let adjustedMinVisibleHeight = safeArea.bottom == .zero ? minVisibleHeight + safeArea.top : minVisibleHeight
            let adjustedOffsetY = isScrollingUp ? 0 : min(max(offsetY, -adjustedMinVisibleHeight), 0)
            
            TitleGradientHeaderView(
                title: title,
                configuration: configuration
            )
            .offset(y: adjustedOffsetY)
            .frame(height: headerHeight)
        }
    }
}

#Preview {
    ScrollableGradientHeaderView(
        title: "Title",
        configuration: GradientHeaderConfiguration(presetColors: .addresses),
        headerHeight: 147,
        minVisibleHeight: 40
    ) {
        VStack(spacing: 35) {
            ForEach(0...25, id: \.self) { (number) in
                Text("Number \(number + 1)")
            }
        }
    }
    .ignoresSafeArea(edges: .top)
}
