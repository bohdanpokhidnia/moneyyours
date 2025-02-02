//
//  SelectMonthView.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 30.06.2024.
//

import SwiftUI
import ComposableArchitecture

struct SelectMonthView: View {
    @Bindable var store: StoreOf<SelectMonthFeature>
    
    var body: some View {
        ScrollableGradientHeaderView(
            title: "Select month",
            configuration: GradientHeaderConfiguration(presetColors: .addresses)
        ) {
            VStack(spacing: 16) {
                ForEach(store.months) { month in
                    Button(month.name) {
                        store.send(.select(month: month))
                    }
                    .buttonStyle(
                        EmojiRowButtonStyle(
                            emoji: month.emoji,
                            emojiBackground: month.color
                        )
                    )
                }
            }
            .padding([.top, .horizontal], 16)
        }
        .ignoresSafeArea(edges: .top)
        .background(.appBackground)
        .onAppear {
            store.send(.onAppear)
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    store.send(.backButtonTapped)
                } label: {
                    Image(systemName: "arrow.backward")
                        .tint(.white)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        SelectMonthView(
            store: Store(
                initialState: SelectMonthFeature.State(selectedMonth: Shared(.january)),
                reducer: {
                    SelectMonthFeature()
                }
            )
        )
    }
}
