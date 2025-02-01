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
            Text("Select Price")
                .font(.headline)
            
            ForEach(Price.allCases, id: \.self) { price in
                Button {
                    store.send(.select(price: price))
                } label: {
                    Text(price.name)
                        .font(.footnote)
                        .foregroundStyle(.black)
                }
                
                Divider()
            }
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    SelectPriceView(
        store: Store(
            initialState: SelectPriceFeature.State(
                selectedPrice: Shared(.fixed(value: 0))
            ),
            reducer: {
                SelectPriceFeature()
            }
        )
    )
}
