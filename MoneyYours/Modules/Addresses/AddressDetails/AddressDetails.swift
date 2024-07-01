//
//  AddressDetails.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 15.06.2024.
//

import Foundation
import ComposableArchitecture

@Reducer
struct AddressDetails {
    @ObservableState
    struct State: Equatable {
        var address: Address
        var monthInvoicesListState = MonthInvoicesList.State()
    }
    
    enum Action {
        case monthInvoiceButtonTapped(MonthInvoice)
        case monthInvoicesListAction(MonthInvoicesList.Action)
    }
    
    var body: some ReducerOf<Self> {
        Scope(state: \.monthInvoicesListState, action: \.monthInvoicesListAction) {
            MonthInvoicesList()
        }
        
        Reduce { (state, action) in
            switch action {
            case .monthInvoiceButtonTapped:
                return .none
                
            case .monthInvoicesListAction:
                return .none
            }
        }
    }
}
