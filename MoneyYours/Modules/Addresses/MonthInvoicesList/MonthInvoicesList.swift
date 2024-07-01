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
        var monthInvoice: MonthInvoice
        var invoiceSelectionListState: InvoiceSelectionList.State
        
        init(
            monthInvoice: MonthInvoice? = nil,
            invoiceSelectionListState: InvoiceSelectionList.State? = nil
        ) {
            self.monthInvoice = monthInvoice ?? .mock
            self.invoiceSelectionListState = InvoiceSelectionList.State(monthInvoice: monthInvoice ?? .mock)
        }
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
            case let .invoiceSelectionListAction(.delegate(.save(monthInvoice))):
                state.monthInvoice = monthInvoice
                return .none
                
            case .invoiceSelectionListAction:
                return .none
            }
        }
    }
}
