//
//  AddAddress.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 12.06.2024.
//

import ComposableArchitecture

@Reducer
struct AddAddress {
    @ObservableState
    struct State: Equatable {
        var isSaveDisabled: Bool = true
        var address: Address
        @Shared(.appColor) var appColor
    }
    
    enum Action {
        case setAddress(name: String)
        case delegate(Delegate)
        case saveButtonTapped
        
        @CasePathable
        enum Delegate: Equatable {
            case save(address: Address)
        }
    }
    
    var body: some ReducerOf<Self> {
        Reduce { (state, action) in
            switch action {
            case let .setAddress(name):
                state.address.name = name
                state.isSaveDisabled = name.isEmpty
                return .none
                
            case .saveButtonTapped:
                guard !state.isSaveDisabled else {
                    return .none
                }
                
                return .run { [address = state.address] (send) in
                    await send(.delegate(.save(address: address)))
                }
                
            case .delegate:
                return .none
            }
        }
    }
}
