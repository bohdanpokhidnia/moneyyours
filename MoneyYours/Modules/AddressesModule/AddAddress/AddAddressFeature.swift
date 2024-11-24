//
//  AddAddressFeature.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 12.06.2024.
//

import ComposableArchitecture
import Foundation

@Reducer
struct AddAddressFeature {
    @ObservableState
    struct State: Equatable {
        var addressName: String = ""
        var isDisableSaveButton: Bool = true
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case saveButtonTapped
        case delegate(Delegate)
        
        @CasePathable
        enum Delegate: Equatable {
            case save(address: Address)
        }
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { (state, action) in
            switch action {
            case .binding(\.addressName):
                state.isDisableSaveButton = state.addressName.isEmpty
                return .none
                
            case .binding:
                return .none
                
            case .saveButtonTapped:
                let address = Address(
                    id: UUID(),
                    name: state.addressName,
                    communalInvoices: []
                )
                return .send(.delegate(.save(address: address)))

            case .delegate:
                return .none
            }
        }
    }
}