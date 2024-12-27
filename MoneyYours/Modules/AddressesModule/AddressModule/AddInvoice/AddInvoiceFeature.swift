//
//  AddInvoiceFeature.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 17.12.2024.
//

import ComposableArchitecture

@Reducer
struct AddInvoiceFeature {
    @ObservableState
    struct State: Equatable {
        var name: String = "Name"
        var invoiceType: CommunalInvoiceType = .electricity
        var selectedPrice: Price = .fixed(value: 0)
        var price: Price = .fixed(value: 0)
        var fixedValue: String = "0.00"
        var calculateValue: String = "0.00"
        var calculateCount: String = "0"
    }
    
    enum Action: BindableAction, ViewAction {
        case binding(BindingAction<State>)
        case view(View)
    }
    
    enum View {
        case invoiceButtonTapped
        case saveButtonTapped
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .binding:
                return .none
                
            case .view(.invoiceButtonTapped):
                state.invoiceType = .garbageDisposal
                return .none
                
            case .view(.saveButtonTapped):
                print("Save: \(state.name)\n\(state.invoiceType.name)\n\(state.price.name)\n\(state.price)")
                return .none
            }
        }
    }
}
