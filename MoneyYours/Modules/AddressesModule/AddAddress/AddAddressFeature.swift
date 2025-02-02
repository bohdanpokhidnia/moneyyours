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
    
    enum Action: BindableAction, ViewAction {
        case binding(BindingAction<State>)
        case view(View)
        case delegate(Delegate)
        
        enum View {
            case backButtonTapped
            case saveButtonTapped
        }
        
        @CasePathable
        enum Delegate: Equatable {
            case addressSaved
        }
    }
    
    @Dependency(\.uuid) var uuid
    @Dependency(\.databaseClient) var databaseClient
    @Dependency(\.dismiss) var dismiss
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { (state, action) in
            switch action {
            case .binding(\.addressName):
                state.isDisableSaveButton = state.addressName.isEmpty
                return .none
                
            case .binding:
                return .none
                
            case .view(.backButtonTapped):
                return .run { _ in
                    await dismiss()
                }
                
            case .view(.saveButtonTapped):
                let address = Address(
                    id: uuid(),
                    name: state.addressName,
                    communalInvoices: []
                    ,
                    state: .active
                )
                return .run { send in
                    try databaseClient.addressDatabase.create(address)
                    await send(.delegate(.addressSaved))
                }

            case .delegate:
                return .none
            }
        }
    }
}
