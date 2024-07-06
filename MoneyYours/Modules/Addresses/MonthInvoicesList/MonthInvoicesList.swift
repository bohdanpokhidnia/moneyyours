//
//  MonthInvoicesList.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 30.06.2024.
//

import ComposableArchitecture

@Reducer
struct MonthInvoicesList {
    @ObservableState
    struct State: Equatable {
        @Shared var monthInvoice: MonthInvoice
    }
    
    enum Action {
        case addInvoiceButtonTapped
        case delegate(Delegate)
        
        @CasePathable
        enum Delegate {
            case addInvoice(Shared<MonthInvoice>)
        }
    }
    
    var body: some ReducerOf<Self> {
        Reduce { (state, action) in
            switch action {
            case .addInvoiceButtonTapped:
                return .send(.delegate(.addInvoice(state.$monthInvoice)))
                
            case .delegate:
                return .none
            }
        }
    }
}
