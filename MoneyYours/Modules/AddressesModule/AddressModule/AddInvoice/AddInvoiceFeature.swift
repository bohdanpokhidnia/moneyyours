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
        var name: String = CommunalInvoiceType.electricity.name
        var invoiceType: CommunalInvoiceType = .electricity
        var price: Price = .fixed(value: 0)
        var isSaveButtonDisabled: Bool = false
    }
    
    enum Action: BindableAction, ViewAction {
        case binding(BindingAction<State>)
        case view(View)
    }
    
    enum View {
        case invoiceButtonTapped
        case priceButtonTapped
        case saveButtonTapped
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .binding:
                state.isSaveButtonDisabled = state.name.trimmingCharacters(in: .whitespaces).isEmpty
                return .none
                
            case .view(.invoiceButtonTapped):
                state.invoiceType = .garbageDisposal
                return .none
                
            case .view(.priceButtonTapped):
                state.price = .fixed(value: 1.223)
                return .none
                
            case .view(.saveButtonTapped):
                print("Save: \(state.name)\n\(state.invoiceType.name)\n\(state.price.name)\n\(state.price.text)")
                return .none
            }
        }
    }
}
