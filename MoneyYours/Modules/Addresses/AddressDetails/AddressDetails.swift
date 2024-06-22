//
//  AddressDetails.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 15.06.2024.
//

import ComposableArchitecture

@Reducer
struct AddressDetails {
    @ObservableState
    struct State: Equatable {
        var address: Address
    }
    
    enum Action {
        case addInvoiceButtonTapped
        case delegate(Delegate)
        
        @CasePathable
        enum Delegate {
            case addInvoice
        }
    }
    
    var body: some ReducerOf<Self> {
        Reduce { (state, action) in
            switch action {
            case .addInvoiceButtonTapped:
                return .send(.delegate(.addInvoice))
                
            case .delegate:
                return .none
            }
        }
    }
}
