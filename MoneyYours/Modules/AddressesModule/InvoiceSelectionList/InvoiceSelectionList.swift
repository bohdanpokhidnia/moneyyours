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
//        @Shared var monthInvoice: MonthInvoice
        var invoices: IdentifiedArrayOf<CommunalInvoice> = []
    }
    
    enum Action {
        case onAppear
        case select(CommunalInvoice)
    }
    
    @Dependency(\.invoicesLoader) private var invoicesLoader
    @Dependency(\.dismiss) private var dismiss
    
    var body: some ReducerOf<Self> {
        Reduce { (state, action) in
            switch action {
            case .onAppear:
                let invoices = invoicesLoader.fetch()
//                state.invoices = IdentifiedArray(uniqueElements: invoices)
                return .none
                
            case let .select(invoice):
//                state.monthInvoice.invoices.append(invoice)
                return .run { _ in
                    await dismiss()
                }
            }
        }
    }
}
