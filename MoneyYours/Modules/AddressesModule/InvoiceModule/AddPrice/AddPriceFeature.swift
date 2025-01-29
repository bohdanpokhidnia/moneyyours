//
//  AddPriceFeature.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 25.01.2025.
//

import ComposableArchitecture

@Reducer
struct AddPriceFeature {
    @ObservableState
    struct State: Equatable {
        var selectedPrice: Price
        var price: Price?
        var focus: Field? = .price
        var priceText: String
        var oldCounterText: String = "0"
        var newCounterText: String = "0"
        var currency: Currency = .UAH
        var isDisableSaveButton: Bool = true
        
        var priceDouble: Double {
            Double(priceText) ?? .zero
        }
        
        var oldCount: Int {
            Int(oldCounterText) ?? 0
        }
        
        var newCount: Int {
            Int(newCounterText) ?? 0
        }
        
        init(selectedPrice: Price) {
            self.selectedPrice = switch selectedPrice {
            case .fixed: .fixed(value: .zero)
            case .calculate: .calculate(value: .zero, count: .zero)
            case .doubleCalculate: .doubleCalculate(first: .calculate(value: .zero, count: .zero), second: .calculate(value: .zero, count: .zero))
            }
            priceText = selectedPrice.sumString
        }
    }
    
    enum Action: BindableAction, ViewAction {
        case binding(BindingAction<State>)
        case updateSaveButtonState
        case view(View)
        case delegate(Delegate)
    }
    
    enum View {
        case saveButtonTapped
    }
    
    enum Field {
        case price
        case oldCounter
        case newCounter
    }
    
    enum Delegate {
        case select(price: Price)
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .binding:
                switch state.selectedPrice {
                case .fixed:
                    state.price = .fixed(value: state.priceDouble)
                    
                case .calculate:
                    let different = state.newCount - state.oldCount
                    state.price = different > .zero ? .calculate(value: state.priceDouble, count: different) : nil
                    
                case .doubleCalculate:
                    break
                }
                return .send(.updateSaveButtonState)
                
            case .updateSaveButtonState:
                state.isDisableSaveButton = (state.price?.sum ?? .zero) <= .zero
                return .none
                
            case .view(.saveButtonTapped):
                guard let price = state.price else {
                    return .none
                }
                return .send(.delegate(.select(price: price)))
                
            case .delegate:
                return .none
            }
        }
    }
}
