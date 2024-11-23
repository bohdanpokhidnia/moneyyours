//
//  AddressSettingsFeature.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 23.11.2024.
//

import ComposableArchitecture

@Reducer
struct AddressSettingsFeature {
    @ObservableState
    struct State: Equatable {
        @Shared var address: Address
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .binding(\.address):
                state.address.name = state.address.name.trimmingCharacters(in: .whitespaces)
                return .none
                
            case .binding:
                return .none
            }
        }
    }
}
