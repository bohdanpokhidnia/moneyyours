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
        @Shared(.inMemory("addInvoicePrice")) var price: Price = .calculate(value: 0, count: 0)
        var isDisableSaveButton: Bool = true
    }
    
    enum Action: BindableAction, ViewAction {
        case binding(BindingAction<State>)
        case view(View)
        case updateSaveButtonState
        case delegate(Delegate)
    }
    
    enum View {
        case backButtonTapped
        case saveButtonTapped
        case priceButtonTapped
    }
    
    enum Delegate {
        case priceButtonTapped(price: Shared<Price>)
    }
    
    @Dependency(\.dismiss) var dismiss
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .binding:
                return .send(.updateSaveButtonState)
                
            case .view(.backButtonTapped):
                return .run { _ in
                    await dismiss()
                }
                
            case .view(.saveButtonTapped):
                print("Save: \(state.name)\n\(state.invoiceType.name)\n\(state.price.name)\n\(state.price.sumString)")
                return .none
                
            case .view(.priceButtonTapped):
                return .send(.delegate(.priceButtonTapped(price: state.$price)))
                
            case .updateSaveButtonState:
                let isEmptyName = state.name.trimmingCharacters(in: .whitespaces).isEmpty
                let isZeroPrice = state.$price.wrappedValue.isZero
                state.isDisableSaveButton = isEmptyName || isZeroPrice
                return .none
                
            case .delegate:
                return .none
            }
        }
    }
}
