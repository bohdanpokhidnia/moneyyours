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
    @ViewBuilder var content: () -> ContentView
    
    @State private var navigationBarHeight: CGFloat = .zero
    @State private var titleSize: CGSize = .zero
    private let titlePadding: CGFloat = 16.0
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                GeometryReader { (proxy) in
                    let rect = proxy.frame(in: .global)
                    
                    Color.clear
                        .preference(key: ViewRectKey.self, value: rect)
                }
                .frame(height: headerHeight)
                .zIndex(1)
                
                content()
            }
        }
        .background {
            NavigationBarHeightReader(navigationBarHeight: $navigationBarHeight)
        }
        .contentMargins(.top, headerHeight, for: .scrollIndicators)
        .overlayPreferenceValue(ViewRectKey.self, alignment: .top) { (rect) in
            let minY = rect.minY
            let isScrollingUp = minY > 0
            let offsetY = isScrollingUp ? 0 : min(max(minY, -navigationBarHeight), 0)
            let scrollProgress = max(min(-minY / (headerHeight - navigationBarHeight), 1), 0)
            let titleScale = 1 - (scrollProgress * 0.2)
            let titleOffsetX = ((rect.maxX / 2) - (titleSize.width / 2) - 16) * scrollProgress + 16
            let titleOffsetY = offsetY - titlePadding / 2
            
            ZStack(alignment: .bottomLeading) {
                GradientHeaderView(configuration: configuration)
                    .offset(y: offsetY)
                    .frame(height: safeArea.top + navigationBarHeight * 2)
                
                titleView
                    .background {
                        GeometryReader { (titleProxy) in
                            Color.clear
                                .onAppear {
                                    titleSize = titleProxy.size
                                }
                                .onChange(of: titleProxy.size) {
                                    titleSize = titleProxy.size
                                }
                        }
                    }
                    .scaleEffect(titleScale)
                    .offset(
                        x: titleOffsetX,
                        y: titleOffsetY
                    )
            }
        }
    }
}

// MARK: - Views

private extension ScrollableGradientHeaderView {
    var titleView: some View {
        Text(title)
            .font(.screenTitle)
            .foregroundStyle(.white)
            .lineLimit(1)
    }
}

#Preview {
    NavigationStack {
        ScrollableGradientHeaderView(
            title: "District",
            configuration: GradientHeaderConfiguration(presetColors: .addresses),
            headerHeight: 147
        ) {
            VStack(spacing: 8) {
                ForEach(0...25, id: \.self) { (number) in
                    RoundedRectangle(cornerRadius: 16)
                        .fill(.gray.opacity(0.2))
                        .frame(height: 20)
                    
                    RoundedRectangle(cornerRadius: 16)
                        .fill(.gray.opacity(0.2))
                        .frame(height: 20)
                        .padding(.trailing, 32)
                    
                    RoundedRectangle(cornerRadius: 16)
                        .fill(.gray.opacity(0.2))
                        .frame(height: 20)
                        .padding(.trailing, 64)
                        .padding(.bottom, 16)
                }
            }
            .padding(.horizontal, 16)
        }
        .ignoresSafeArea(edges: .top)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Image(systemName: "gear")
                    .foregroundStyle(.white)
            }
        }
        .setupNavigationTransparent()
    }
}
