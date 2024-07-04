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
        case monthInvoiceButtonTapped(MonthInvoice)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { (state, action) in
            switch action {
            case .monthInvoiceButtonTapped:
                return .none
            }
        }
    }
}
