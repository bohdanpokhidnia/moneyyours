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
    
    @State private var fullNavigationBarHeight: CGFloat = .zero
    @State var titleWidth: CGFloat = .zero
    private let titleBottomPadding: CGFloat = 16.0
    
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
            NavigationBarHeightReader(fullNavigationBarHeight: $fullNavigationBarHeight)
        }
        .contentMargins(.top, headerHeight, for: .scrollIndicators)
        .overlayPreferenceValue(ViewRectKey.self, alignment: .top) { (rect) in
            let minY = rect.minY
            let isScrollingUp = minY > 0
            let adjustedMinVisibleHeight = fullNavigationBarHeight - safeArea.top
            let offsetY = isScrollingUp ? 0 : min(max(minY, -adjustedMinVisibleHeight), 0)
            let scrollProgress = max(min(-minY / (headerHeight - fullNavigationBarHeight), 1), 0)
            let titleOffsetX = ((rect.maxX / 2) - (titleWidth / 2)) * scrollProgress - 8 * scrollProgress
            let titleOffsetY = 1 - (scrollProgress * titleBottomPadding * 2.5)
            
            ZStack(alignment: .bottomLeading) {
                GradientHeaderView(configuration: configuration)
                    .offset(y: offsetY)
                    .frame(height: headerHeight)
                
                titleView
                    .background {
                        GeometryReader { (titleProxy) in
                            Color.clear
                                .onAppear {
                                    titleWidth = titleProxy.size.width
                                }
                                .onChange(of: titleProxy.size.width) {
                                    titleWidth = titleProxy.size.width
                                }
                        }
                    }
                    .scaleEffect(1 - (scrollProgress * 0.2))
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
            .padding(.leading, 16)
            .padding(.bottom, titleBottomPadding)
    }
}

#Preview {
    NavigationStack {
        ScrollableGradientHeaderView(
            title: "Money Yours",
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
    }
}
