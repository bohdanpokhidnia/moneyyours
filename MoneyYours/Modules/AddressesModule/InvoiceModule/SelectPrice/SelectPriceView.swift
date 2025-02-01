//
//  SelectPriceView.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 30.01.2025.
//

import ComposableArchitecture
import SwiftUI

struct SelectPriceView: View {
    @Bindable var store: StoreOf<SelectPriceFeature>
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Select price")
                .font(.title)
                .fontWeight(.bold)
            
            VStack(spacing: 0) {
                ForEach(Price.allCases, id: \.self) { price in
                    Button {
                        store.send(.select(price: price))
                    } label: {
                        let isSelected = store.selectedPrice.wrappedValue == price
                        
                        SelectPriceRow(
                            emoji: price.emoji,
                            title: price.name
                        )
                        .frame(maxWidth: .infinity, minHeight: 56, alignment: .leading)
                        .opacity(isSelected ? 1.0 : 0.5)
                    }
                    
                    Divider()
                }
            }
        }
        .padding(.horizontal, 16)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    SelectPriceView(
        store: Store(
            initialState: SelectPriceFeature.State(
                selectedPrice: Shared(.fixed(value: .zero))
            ),
            reducer: {
                SelectPriceFeature()
            }
        )
    )
}
