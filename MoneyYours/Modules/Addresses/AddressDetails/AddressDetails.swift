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
        var invoicesList = InvoicesList.State()
    }
    
    enum Action {
        case addInvoiceButtonTapped
        case invoicesList(InvoicesList.Action)
    }
    
    var body: some ReducerOf<Self> {
        Scope(state: \.invoicesList, action: \.invoicesList) {
            InvoicesList()
        }
        
        Reduce { (state, action) in
            switch action {
            case .addInvoiceButtonTapped:
                return .none
                
            case let .invoicesList(.delegate(.save(invoice))):
                state.address.invoices.append(invoice)
                return .none
                
            case .invoicesList:
                return .none
            }
        }
    }
}
