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
        var price: Price = .calculate(value: 0, count: 0)
        var isSaveButtonDisabled: Bool = false
    }
    
    enum Action: BindableAction, ViewAction {
        case binding(BindingAction<State>)
        case view(View)
        case updatePrice(_ price: Price)
        case delegate(Delegate)
    }
    
    enum View {
        case saveButtonTapped
        case priceButtonTapped
    }
    
    enum Delegate {
        case priceButtonTapped(price: Price)
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .binding:
                state.isSaveButtonDisabled = state.name.trimmingCharacters(in: .whitespaces).isEmpty
                return .none
                
            case .view(.saveButtonTapped):
                print("Save: \(state.name)\n\(state.invoiceType.name)\n\(state.price.name)\n\(state.price.sumString)")
                return .none
                
            case .view(.priceButtonTapped):
                return .send(.delegate(.priceButtonTapped(price: state.price)))
                
            case let .updatePrice(price):
                state.price = price
                return .none
                
            case .delegate:
                return .none
            }
        }
    }
}
