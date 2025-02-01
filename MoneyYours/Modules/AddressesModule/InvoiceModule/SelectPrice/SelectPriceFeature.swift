//
//  SelectPriceFeature.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 30.01.2025.
//

import ComposableArchitecture

@Reducer
struct SelectPriceFeature {
    @ObservableState
    struct State: Equatable {
        var selectedPrice: Shared<Price>
    }
    
    enum Action {
        case select(price: Price)
    }
    
    @Dependency(\.dismiss) var dismiss
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .select(price):
                state.selectedPrice.wrappedValue = price
                return .none
            }
        }
    }
}
