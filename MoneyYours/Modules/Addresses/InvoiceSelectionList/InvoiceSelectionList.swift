//
//  InvoiceSelectionList.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 16.06.2024.
//

import ComposableArchitecture

@Reducer
struct InvoiceSelectionList {
    @ObservableState
    struct State: Equatable {
        var monthInvoice: MonthInvoice
        var invoices: IdentifiedArrayOf<Invoice> = []
    }
    
    enum Action {
        case onAppear
        case select(Invoice)
        case delegate(Delegate)
        
        @CasePathable
        enum Delegate {
            case save(MonthInvoice)
        }
    }
    
    @Dependency(\.invoicesLoader) private var invoicesLoader
    
    var body: some ReducerOf<Self> {
        Reduce { (state, action) in
            switch action {
            case .onAppear:
                let invoices = invoicesLoader.fetch()
                state.invoices = IdentifiedArray(uniqueElements: invoices)
                return .none
                
            case let .select(invoice):
                state.monthInvoice.invoices.append(invoice)
                return .send(.delegate(.save(state.monthInvoice)))
                
            case .delegate:
                return .none
            }
        }
    }
}
