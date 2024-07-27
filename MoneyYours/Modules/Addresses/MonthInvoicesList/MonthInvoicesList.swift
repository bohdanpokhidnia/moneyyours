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
        var displayInvoices: IdentifiedArrayOf<DisplayInvoice> = []
    }
    
    enum Action {
        case onAppear
        case addInvoiceButtonTapped
        case delegate(Delegate)
        case setPast(CommunalInvoice.ID, String)
        case setNow(CommunalInvoice.ID, String)
        
        @CasePathable
        enum Delegate {
            case addInvoice(Shared<MonthInvoice>)
        }
    }
    
    var body: some ReducerOf<Self> {
        Reduce { (state, action) in
            switch action {
            case .onAppear:
                state.displayInvoices = IdentifiedArray(uniqueElements: state.monthInvoice.invoices.map {
                    MonthInvoicesList.DisplayInvoice(
                        invoice: $0,
                        past: $0.pastValue > .zero ? $0.pastValue.description : "",
                        now: $0.nowValue > .zero ? $0.nowValue.description : ""
                    )
                })
                return .none
                
            case .addInvoiceButtonTapped:
                return .send(.delegate(.addInvoice(state.$monthInvoice)))
                
            case .delegate:
                return .none
                
            case let .setPast(invoiceId, past):
                guard let pastDouble = Double(past) else {
                    return .none
                }
                
                state.monthInvoice.invoices[id: invoiceId]?.pastValue = pastDouble
                return .none
                
            case let .setNow(invoiceId, now):
                guard let displayInvoice = state.displayInvoices[id: invoiceId] else {
                    return .none
                }
                guard let nowDouble = Double(now) else {
                    return .none
                }
                let invoice = displayInvoice.invoice
                let count: Double = nowDouble - invoice.pastValue
                let amount: Double = invoice.price * count
                
                state.monthInvoice.invoices[id: invoiceId]?.nowValue = nowDouble
                state.monthInvoice.invoices[id: invoiceId]?.amount = amount
                state.displayInvoices[id: invoiceId]?.invoice.amount = amount
                print("[dev] \(invoice.type.name) price: \(invoice.price) * \(count) = \(amount)")
                return .none
            }
        }
    }
}

// MARK: - Display model

extension MonthInvoicesList {
    struct DisplayInvoice: Identifiable, Equatable {
        var id: CommunalInvoice.ID { invoice.id }
        var invoice: CommunalInvoice
        var past: String
        var now: String
    }
}
