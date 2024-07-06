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
        @Shared var address: Address
    }
    
    enum Action {
        case monthInvoiceButtonTapped(YearInvoice, MonthInvoice)
        case delegate(Delegate)
        
        @CasePathable
        enum Delegate {
            case select(Shared<MonthInvoice>)
        }
    }
    
    var body: some ReducerOf<Self> {
        Reduce { (state, action) in
            switch action {
            case let .monthInvoiceButtonTapped(yearInvoice, monthInvoice):
                guard let sharedMonthInvoice = state.$address.yearInvoices
                    .elements.first(where: { $0.id == yearInvoice.id })?
                    .monthInvoices.elements.first(where: { $0.id == monthInvoice.id })
                else {
                    return .none
                }
                
                return .send(.delegate(.select(sharedMonthInvoice)))
                
            case .delegate:
                return .none
            }
        }
    }
}
