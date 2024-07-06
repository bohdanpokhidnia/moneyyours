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
        var invoiceSelectionListState = InvoiceSelectionList.State()
    }
    
    enum Action {
        case invoiceSelectionListAction(InvoiceSelectionList.Action)
    }
    
    var body: some ReducerOf<Self> {
        Scope(state: \.invoiceSelectionListState, action: \.invoiceSelectionListAction) {
            InvoiceSelectionList()
        }
        
        Reduce { (state, action) in
            switch action {
            case let .invoiceSelectionListAction(.delegate(.save(invoice))):
                state.monthInvoice.invoices.append(invoice)
                return .none
                
            case .invoiceSelectionListAction:
                return .none
            }
        }
    }
}
